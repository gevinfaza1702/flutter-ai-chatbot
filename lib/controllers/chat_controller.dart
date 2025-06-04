import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/chat_session.dart';
import '../models/chat_message.dart';

class ChatController {
  final List<ChatSession> sessions = [];
  int _nextId = 1;

  ChatSession createSession() {
    final session = ChatSession(id: _nextId++, title: 'Chat Session');
    sessions.add(session);
    return session;
  }

  ChatSession? getSession(int id) {
    return sessions.firstWhere((s) => s.id == id, orElse: () => createSession());
  }

  Future<void> sendMessageToBot(ChatSession session, String userInput) async {
    final userMsg = ChatMessage(text: userInput, isUser: true);
    session.messages.add(userMsg);

    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIApiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': userInput}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];
        session.messages.add(ChatMessage(text: content, isUser: false));
      } else {
        session.messages.add(ChatMessage(
            text: 'Error ${response.statusCode}: ${response.reasonPhrase}',
            isUser: false));
      }
    } catch (e) {
      session.messages
          .add(ChatMessage(text: 'Error: $e', isUser: false));
    }
  }
}
