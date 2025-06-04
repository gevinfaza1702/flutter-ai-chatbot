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
      appBar: AppBar(
        title: const Text('🤖 AI Chatbot'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onThemeChanged,
          ),
        ],
      ),
      body: sessions.isEmpty ? _buildEmptyState() : _buildSessionList(sessions),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final session = chatController.createSession();
          Navigator.pushNamed(context, '/chat', arguments: session.id)
              .then((_) => setState(() {}));
        },
        icon: const Icon(Icons.add),
        label: const Text("New Chat"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            if (sessions.isEmpty) {
              final s = chatController.createSession();
              Navigator.pushNamed(context, '/chat', arguments: s.id);
            } else {
              Navigator.pushNamed(context, '/chat',
                  arguments: sessions.last.id);
            }
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/settings');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/help');
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Belum ada sesi percakapan',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text('Tekan tombol + untuk memulai obrolan baru'),
        ],
      ),
    );
  }

  Widget _buildSessionList(List<ChatSession> sessions) {
    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: const Icon(Icons.chat, color: Colors.teal),
            title: Text(session.title),
            subtitle: Text('Pesan: ${session.messages.length}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, '/chat', arguments: session.id)
                  .then((_) => setState(() {}));
            },
          ),
        );
      },
    );
  }
}
