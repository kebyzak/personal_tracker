class Habit {
  final int? id;
  final String title;
  final String description;
  final String emoji;
  final List<int> daysOfWeek; // 0=Mon, 6=Sun
  final DateTime createdAt;
  final DateTime startDate;

  Habit({
    this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.daysOfWeek,
    required this.createdAt,
    required this.startDate,
  });
} 
