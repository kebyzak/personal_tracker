
import 'package:table_calendar/table_calendar.dart';

import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_completion.dart';

abstract class HabitState {}

class HabitInitial extends HabitState {}
class HabitLoading extends HabitState {}
class HabitLoaded extends HabitState {
  final List<Habit> habits;
  final List<HabitCompletion> completions;
  final DateTime selectedDate;
  final CalendarFormat calendarFormat;
  HabitLoaded(
      this.habits, {
        this.completions = const [],
        required this.selectedDate,
        this.calendarFormat = CalendarFormat.week,
      });
}
class HabitCompletionsLoaded extends HabitState {
  final List<HabitCompletion> completions;
  HabitCompletionsLoaded(this.completions);
}
class HabitError extends HabitState {
  final String message;
  HabitError(this.message);
} 
