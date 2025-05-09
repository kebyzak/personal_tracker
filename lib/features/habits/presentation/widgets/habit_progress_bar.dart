import 'package:flutter/material.dart';

class HabitProgressBar extends StatelessWidget {
  final double percent;
  final int completedCount;
  final int totalCount;

  const HabitProgressBar({
    super.key,
    required this.percent,
    required this.completedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) {
      return const Text('No habits for this day');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: percent,
          minHeight: 8,
          backgroundColor: Colors.grey[800],
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Text(
          '$completedCount of $totalCount habits completed',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
} 
