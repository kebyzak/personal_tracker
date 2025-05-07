import 'package:flutter/material.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habit Tracker')),
      body: const Center(child: Text('Habit Tracker')), // TODO: Add habit tracker UI
    );
  }
} 
