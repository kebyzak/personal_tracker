import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class UpdateHabit {
  final HabitRepository repository;
  UpdateHabit(this.repository);

  Future<void> call(Habit habit) {
    return repository.updateHabit(habit);
  }
} 
