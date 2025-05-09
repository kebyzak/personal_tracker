import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/add_habit_dialog.dart';
import '../widgets/habit_list.dart';
import '../widgets/habit_progress_bar.dart';
import '../widgets/habit_month_stats.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import '../bloc/habit_state.dart';
import '../../domain/entities/habit.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure habits are loaded when the page is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HabitBloc>().add(LoadAllHabits());
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Habit Tracker')),
      body: BlocBuilder<HabitBloc, HabitState>(
        builder: (context, state) {
        
          if (state is HabitLoaded) {
            if (state.habits.isEmpty) {
              return const Center(child: Text('No habits yet'));
            }
            final habits = state.habits;
            final completions = state.completions;
            final selectedDate = state.selectedDate;
            final calendarFormat = state.calendarFormat;

            final weekday = selectedDate.weekday - 1;
            final habitsForDay = habits.where((h) =>
              h.daysOfWeek.contains(weekday) &&
              !selectedDate.isBefore(h.startDate)
            ).toList();
            final completionsForDay = completions.where((c) =>
              c.date.year == selectedDate.year &&
              c.date.month == selectedDate.month &&
              c.date.day == selectedDate.day &&
              c.isDone &&
              habitsForDay.any((h) => h.id == c.habitId)
            ).toList();
            final percent = habitsForDay.isEmpty
                ? 0.0
                : completionsForDay.length / habitsForDay.length;

            // Achieved: percent of all completed habits out of all available for the month
            int daysInMonth = DateUtils.getDaysInMonth(selectedDate.year, selectedDate.month);
            int available = 0;
            int completed = 0;
            for (int day = 1; day <= daysInMonth; day++) {
              final date = DateTime(selectedDate.year, selectedDate.month, day);
              final wday = date.weekday - 1;
              final habitsForThisDay = habits.where((h) =>
                h.daysOfWeek.contains(wday) &&
                !date.isBefore(h.startDate)
              ).toList();
              available += habitsForThisDay.length;
              completed += completions.where((c) =>
                c.date.year == date.year &&
                c.date.month == date.month &&
                c.date.day == date.day &&
                c.isDone &&
                habitsForThisDay.any((h) => h.id == c.habitId)
              ).length;
            }
            final achievedPercent = available == 0 ? 0.0 : completed / available;

            // Streak: current streak of days up to today where all habits for the day were completed
            int streak = 0;
            for (int offset = 0; offset < daysInMonth; offset++) {
              final date = DateTime(selectedDate.year, selectedDate.month, DateTime.now().day - offset);
              if (date.isAfter(DateTime.now()) || date.month != selectedDate.month) continue;
              final wday = date.weekday - 1;
              final habitsForThisDay = habits.where((h) =>
                h.daysOfWeek.contains(wday) &&
                !date.isBefore(h.startDate)
              ).toList();
              if (habitsForThisDay.isEmpty) continue;
              final completionsForThisDay = completions.where((c) =>
                c.date.year == date.year &&
                c.date.month == date.month &&
                c.date.day == date.day &&
                c.isDone &&
                habitsForThisDay.any((h) => h.id == c.habitId)
              ).toList();
              if (completionsForThisDay.length == habitsForThisDay.length) {
                streak++;
              } else {
                break;
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: selectedDate,
                  selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                  onDaySelected: (selected, focused) {
                    context.read<HabitBloc>().add(ChangeSelectedDate(selected));
                  },
                  calendarFormat: calendarFormat,
                  onFormatChanged: (format) {
                    context.read<HabitBloc>().add(ChangeCalendarFormat(format));
                  },
                  availableCalendarFormats: const {
                    CalendarFormat.week: 'Week',
                    CalendarFormat.month: 'Month',
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  eventLoader: (day) {
                    final normalized = DateTime(day.year, day.month, day.day);
                    final wday = normalized.weekday - 1;
                    final habitsForDay =
                        habits.where((h) => h.daysOfWeek.contains(wday)).toList();
                    if (habitsForDay.isEmpty) return [];
                    final completionsForDay = completions
                        .where((c) =>
                            c.date.year == normalized.year &&
                            c.date.month == normalized.month &&
                            c.date.day == normalized.day &&
                            c.isDone)
                        .toList();
                    if (completionsForDay.length == habitsForDay.length) {
                      return [true];
                    }
                    return [];
                  },
                ),
                if (calendarFormat == CalendarFormat.week) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: HabitProgressBar(
                      percent: percent,
                      completedCount: completionsForDay.length,
                      totalCount: habitsForDay.length,
                    ),
                  ),
                  Expanded(
                    child: HabitList(
                      habitsForDay: habitsForDay,
                      completionsForDay: completionsForDay,
                      selectedDate: selectedDate,
                    ),
                  ),
                ] else ...[
                  HabitMonthStats(
                    monthPercent: achievedPercent.toDouble(),
                    maxStreak: streak,
                  ),
                ],
              ],
            );
          }
          return Text("");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (context) => const AddHabitDialog(),
          );
          if (result != null) {
            final habit = Habit(
              title: result['title'] ?? '',
              description: result['description'] ?? '',
              emoji: result['emoji'] ?? '🙂',
              daysOfWeek: List<int>.from(result['daysOfWeek'] ?? [0]),
              createdAt: DateTime.now(),
              startDate: result['startDate'] ?? DateTime.now(),
            );
            context.read<HabitBloc>().add(AddHabitEvent(habit));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
