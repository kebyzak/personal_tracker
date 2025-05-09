
import 'package:drift/drift.dart';
import 'package:personal_tracker/core/data/database/app_database.dart';
import 'package:personal_tracker/features/habits/domain/entities/habit.dart' as entity;

class HabitLocalDataSource {
  final AppDatabase db;
  HabitLocalDataSource(this.db);

  Future<List<entity.Habit>> getAllHabits() async {
    final rows = await db.select(db.habits).get();
    return rows.map(_toHabitEntity).toList();
  }

  Future<entity.Habit?> getHabitById(int id) async {
    final row = await (db.select(db.habits)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toHabitEntity(row);
  }

  Future<void> addHabit(entity.Habit habit) async {
    await db.into(db.habits).insert(
      HabitsCompanion(
        title: Value(habit.title),
        description: Value(habit.description),
        emoji: Value(habit.emoji),
        daysOfWeek: Value(habit.daysOfWeek.join(',')),
        createdAt: Value(habit.createdAt),
        startDate: Value(habit.startDate),
      ),
    );
  }

  Future<void> updateHabit(entity.Habit habit) async {
    await (db.update(db.habits)..where((tbl) => tbl.id.equals(habit.id!))).write(
      HabitsCompanion(
        title: Value(habit.title),
        description: Value(habit.description),
        emoji: Value(habit.emoji),
        daysOfWeek: Value(habit.daysOfWeek.join(',')),
        createdAt: Value(habit.createdAt),
        startDate: Value(habit.startDate),
      ),
    );
  }

  Future<void> deleteHabit(int id) async {
    await (db.delete(db.habits)..where((tbl) => tbl.id.equals(id))).go();
  }

  entity.Habit _toHabitEntity(Habit row) {
    return entity.Habit(
      id: row.id,
      title: row.title,
      description: row.description,
      emoji: row.emoji,
      daysOfWeek: row.daysOfWeek.split(',').map((e) => int.parse(e)).toList(),
      createdAt: row.createdAt,
      startDate: row.startDate,
    );
  }
} 
