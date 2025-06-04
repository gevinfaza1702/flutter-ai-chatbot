import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';
import '../models/chat_session.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeChanged;
  const HomePage({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final chatController = AppController.instance.chatController;
    final sessions = chatController.sessions;

    return Scaffold(
      appBar: AppBar(title: const Text('AI Chatbot')),
      body: _buildHome(sessions),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final session = chatController.createSession();
          Navigator.pushNamed(context, '/chat', arguments: session.id).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            if (sessions.isEmpty) {
              final s = chatController.createSession();
              Navigator.pushNamed(context, '/chat', arguments: s.id);
            } else {
              Navigator.pushNamed(context, '/chat', arguments: sessions.last.id);
            }
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/settings');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/help');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
        ],
      ),
    );
  }

  Widget _buildHome(List<ChatSession> sessions) {
    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return ListTile(
          title: Text(session.title),
          subtitle: Text('Messages: ${session.messages.length}'),
          onTap: () => Navigator.pushNamed(context, '/chat', arguments: session.id).then((_) => setState(() {})),
        );
      },
    );
  }
}

