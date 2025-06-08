import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/chat_session.dart';
import '../models/chat_message.dart';

class ChatController {
  final List<ChatSession> sessions = [];
  int _nextId = 1;
  DateTime? _lastRequestTime; // Tambahkan cooldown timer

  ChatSession createSession() {
    final session = ChatSession(id: _nextId++, title: 'Chat Session');
    sessions.add(session);
    return session;
  }

  ChatSession? getSession(int id) {
    return sessions.firstWhere((s) => s.id == id,
        orElse: () => createSession());
  }

  Future<void> sendMessageToBot(ChatSession session, String userInput) async {
    final now = DateTime.now();

    // ✅ Batasi request setiap 5 detik
    if (_lastRequestTime != null &&
        now.difference(_lastRequestTime!).inSeconds < 5) {
      session.messages.add(ChatMessage(
        text: 'Tunggu 5 detik sebelum mengirim pesan lagi.',
        isUser: false,
      ));
      return;
    }

    _lastRequestTime = now;

    // Tambahkan pesan user
    final userMsg = ChatMessage(text: userInput, isUser: true);
    session.messages.add(userMsg);

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$geminiApiKey',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": userInput}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final replyText = data['candidates'][0]['content']['parts'][0]['text'];
        session.messages.add(ChatMessage(text: replyText, isUser: false));
      } else {
        session.messages.add(ChatMessage(
            text: 'Error ${response.statusCode}: ${response.reasonPhrase}',
            isUser: false));
      }
    } catch (e) {
      session.messages.add(ChatMessage(text: 'Error: $e', isUser: false));
    }
  }
}
