import 'package:flutter/material.dart';

class SleepPage extends StatelessWidget {
  const SleepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sleep Tracker')),
      body: const Center(child: Text('Sleep Tracker')), // TODO: Add sleep tracker UI
    );
  }
} 
