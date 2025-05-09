import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class GetAllHabits {
  final HabitRepository repository;
  GetAllHabits(this.repository);

  Future<List<Habit>> call() {
    return repository.getAllHabits();
  }
} 
