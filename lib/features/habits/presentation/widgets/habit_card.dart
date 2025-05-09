import 'package:flutter/material.dart';

class HabitCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final bool completed;

  const HabitCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(emoji, style: const TextStyle(fontSize: 32)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: completed
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.radio_button_unchecked),
    );
  }
} 
