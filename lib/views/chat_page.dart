import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';
import '../models/chat_message.dart';
import '../components/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final int sessionId;
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sessionId = ModalRoute.of(context)?.settings.arguments as int? ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    final chatController = AppController.instance.chatController;
    final session = chatController.getSession(sessionId)!;
    return Scaffold(
      appBar: AppBar(title: Text(session.title)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: session.messages.length,
              itemBuilder: (context, index) {
                final msg = session.messages[index];
                return ChatBubble(message: msg);
              },
            ),
          ),
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final text = _controller.text.trim();
                    if (text.isEmpty || _loading) return;
                    _controller.clear();
                    setState(() => _loading = true);
                    await chatController.sendMessageToBot(session, text);
                    setState(() => _loading = false);
                    await Future.delayed(const Duration(milliseconds: 100));
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
