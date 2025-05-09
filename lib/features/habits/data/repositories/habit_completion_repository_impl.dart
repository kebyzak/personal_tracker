import '../../domain/entities/habit_completion.dart';
import '../../domain/repositories/habit_completion_repository.dart';
import '../datasources/habit_completion_local_datasource.dart';

class HabitCompletionRepositoryImpl implements HabitCompletionRepository {
  final HabitCompletionLocalDataSource localDataSource;
  HabitCompletionRepositoryImpl(this.localDataSource);

  @override
  Future<List<HabitCompletion>> getCompletionsForDate(DateTime date) => localDataSource.getCompletionsForDate(date);

  @override
  Future<List<HabitCompletion>> getCompletionsForHabit(int habitId) => localDataSource.getCompletionsForHabit(habitId);

  @override
  Future<void> toggleCompletion(int habitId, DateTime date) => localDataSource.toggleCompletion(habitId, date);
} 
