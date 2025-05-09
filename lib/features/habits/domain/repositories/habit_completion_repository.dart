import '../entities/habit_completion.dart';

abstract class HabitCompletionRepository {
  Future<List<HabitCompletion>> getCompletionsForDate(DateTime date);
  Future<List<HabitCompletion>> getCompletionsForHabit(int habitId);
  Future<void> toggleCompletion(int habitId, DateTime date);
} 
