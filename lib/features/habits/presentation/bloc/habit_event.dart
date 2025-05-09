import 'package:table_calendar/table_calendar.dart';

import '../../domain/entities/habit.dart';

abstract class HabitEvent {}

class LoadAllHabits extends HabitEvent {}
class AddHabitEvent extends HabitEvent {
  final Habit habit;
  AddHabitEvent(this.habit);
}
class UpdateHabitEvent extends HabitEvent {
  final Habit habit;
  UpdateHabitEvent(this.habit);
}
class DeleteHabitEvent extends HabitEvent {
  final int id;
  DeleteHabitEvent(this.id);
}
class ToggleHabitCompletionEvent extends HabitEvent {
  final int habitId;
  final DateTime date;
  ToggleHabitCompletionEvent(this.habitId, this.date);
}
class LoadHabitCompletionsEvent extends HabitEvent {
  final DateTime date;
  LoadHabitCompletionsEvent(this.date);
}
class ChangeSelectedDate extends HabitEvent {
  final DateTime selectedDate;
  ChangeSelectedDate(this.selectedDate);
}
class ChangeCalendarFormat extends HabitEvent {
  final CalendarFormat format;
  ChangeCalendarFormat(this.format);
}
