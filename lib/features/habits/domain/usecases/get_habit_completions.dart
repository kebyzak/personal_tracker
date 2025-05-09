import '../entities/habit_completion.dart';
import '../repositories/habit_completion_repository.dart';

class GetHabitCompletions {
  final HabitCompletionRepository repository;
  GetHabitCompletions(this.repository);

  Future<List<HabitCompletion>> call(DateTime date) {
    return repository.getCompletionsForDate(date);
  }
} 
