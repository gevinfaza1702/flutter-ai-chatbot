import 'dart:async';
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

  Stream<ChatMessage> sendMessage(ChatSession session, String text) async* {
    final userMsg = ChatMessage(text: text, isUser: true);
    session.messages.add(userMsg);
    yield userMsg;

    await Future.delayed(const Duration(seconds: 1));
    final botMsg = ChatMessage(text: 'Bot: $text', isUser: false);
    session.messages.add(botMsg);
    yield botMsg;
  }
}
