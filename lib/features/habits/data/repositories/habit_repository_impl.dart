import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';
import '../datasources/habit_local_datasource.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource localDataSource;
  HabitRepositoryImpl(this.localDataSource);

  @override
  Future<List<Habit>> getAllHabits() => localDataSource.getAllHabits();

  @override
  Future<Habit?> getHabitById(int id) => localDataSource.getHabitById(id);

  @override
  Future<void> addHabit(Habit habit) => localDataSource.addHabit(habit);

  @override
  Future<void> updateHabit(Habit habit) => localDataSource.updateHabit(habit);

  @override
  Future<void> deleteHabit(int id) => localDataSource.deleteHabit(id);
} 
