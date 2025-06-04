import 'chat_message.dart';

class ChatSession {
  final int id;
  final String title;
  final List<ChatMessage> messages;

  ChatSession({required this.id, required this.title}) : messages = [];
}
