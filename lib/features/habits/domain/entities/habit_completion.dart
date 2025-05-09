class HabitCompletion {
  final int? id;
  final int habitId;
  final DateTime date;
  final bool isDone;

  HabitCompletion({
    this.id,
    required this.habitId,
    required this.date,
    required this.isDone,
  });
} 
