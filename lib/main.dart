import 'package:flutter/material.dart';
import 'views/splash_screen.dart';
import 'views/login_page.dart';
import 'views/register_page.dart';
import 'views/home_page.dart';
import 'views/chat_page.dart';
import 'views/profile_page.dart';
import 'views/settings_page.dart';
import 'views/help_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chatbot',
      themeMode: _themeMode,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      darkTheme: ThemeData.dark(useMaterial3: true),
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/home': (_) => HomePage(onThemeChanged: _toggleTheme),
        '/chat': (_) => const ChatPage(),
        '/profile': (_) => const ProfilePage(),
        '/settings': (_) => SettingsPage(onThemeChanged: _toggleTheme),
        '/help': (_) => const HelpPage(),
      },
      initialRoute: '/',
    );
  }
}
