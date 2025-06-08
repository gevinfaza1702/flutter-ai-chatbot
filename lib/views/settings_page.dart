import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback onThemeChanged;
  const SettingsPage({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (_) => widget.onThemeChanged(),
          ),
          SwitchListTile(
            title: const Text('Notifications'),
            value: _notifications,
            onChanged: (val) => setState(() => _notifications = val),
          ),
        ],
      ),
    );
  }
}
