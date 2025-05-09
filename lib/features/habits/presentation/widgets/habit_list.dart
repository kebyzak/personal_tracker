import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_completion.dart';
import 'habit_card.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habitsForDay;
  final List<HabitCompletion> completionsForDay;
  final DateTime selectedDate;

  const HabitList({
    super.key,
    required this.habitsForDay,
    required this.completionsForDay,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    if (habitsForDay.isEmpty) {
      return const Center(child: Text('No habits for this day.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: habitsForDay.length,
      itemBuilder: (context, index) {
        final habit = habitsForDay[index];
        final isDone = completionsForDay.any((c) => c.habitId == habit.id && c.isDone);
        return GestureDetector(
          onTap: () => context.read<HabitBloc>().add(ToggleHabitCompletionEvent(habit.id!, selectedDate)),
          onLongPress: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Habit'),
                content: Text('Are you sure you want to delete "${habit.title}"?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
            if (confirmed == true) {
              context.read<HabitBloc>().add(DeleteHabitEvent(habit.id!));
            }
          },
          child: HabitCard(
            emoji: habit.emoji,
            title: habit.title,
            completed: isDone,
            subtitle: habit.description,
          ),
        );
      },
    );
  }
} 
