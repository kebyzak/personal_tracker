import '../entities/habit.dart';

abstract class HabitRepository {
  Future<List<Habit>> getAllHabits();
  Future<Habit?> getHabitById(int id);
  Future<void> addHabit(Habit habit);
  Future<void> updateHabit(Habit habit);
  Future<void> deleteHabit(int id);
} 
