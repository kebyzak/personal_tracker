import '../repositories/habit_completion_repository.dart';

class ToggleHabitCompletion {
  final HabitCompletionRepository repository;
  ToggleHabitCompletion(this.repository);

  Future<void> call(int habitId, DateTime date) {
    return repository.toggleCompletion(habitId, date);
  }
} 
