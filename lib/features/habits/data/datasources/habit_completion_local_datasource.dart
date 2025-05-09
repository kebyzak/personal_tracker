import 'package:drift/drift.dart';
import 'package:personal_tracker/core/data/database/app_database.dart';
import 'package:personal_tracker/features/habits/domain/entities/habit_completion.dart' as entity;

class HabitCompletionLocalDataSource {
  final AppDatabase db;
  HabitCompletionLocalDataSource(this.db);

  Future<List<entity.HabitCompletion>> getCompletionsForDate(DateTime date) async {
    final rows = await (db.select(db.habitCompletions)
      ..where((tbl) => tbl.date.equals(DateTime(date.year, date.month, date.day))))
      .get();
    return rows.map<entity.HabitCompletion>(_toEntity).toList();
  }

  Future<List<entity.HabitCompletion>> getCompletionsForHabit(int habitId) async {
    final rows = await (db.select(db.habitCompletions)
      ..where((tbl) => tbl.habitId.equals(habitId)))
      .get();
    return rows.map<entity.HabitCompletion>(_toEntity).toList();
  }

  Future<void> toggleCompletion(int habitId, DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final existing = await (db.select(db.habitCompletions)
      ..where((tbl) => tbl.habitId.equals(habitId) & tbl.date.equals(normalizedDate)))
      .getSingleOrNull();
    if (existing == null) {
      await db.into(db.habitCompletions).insert(
        HabitCompletionsCompanion(
          habitId: Value(habitId),
          date: Value(normalizedDate),
          isDone: const Value(true),
        ),
      );
    } else {
      await (db.update(db.habitCompletions)
        ..where((tbl) => tbl.id.equals(existing.id)))
        .write(HabitCompletionsCompanion(isDone: Value(!existing.isDone)));
    }
  }

  entity.HabitCompletion _toEntity(HabitCompletion row) {
    return entity.HabitCompletion(
      id: row.id,
      habitId: row.habitId,
      date: row.date,
      isDone: row.isDone,
    );
  }
} 
