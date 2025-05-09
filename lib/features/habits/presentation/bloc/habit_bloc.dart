import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_all_habits.dart';
import '../../domain/usecases/add_habit.dart';
import '../../domain/usecases/update_habit.dart';
import '../../domain/usecases/delete_habit.dart';
import '../../domain/usecases/toggle_habit_completion.dart';
import '../../domain/usecases/get_habit_completions.dart';
import 'habit_event.dart';
import 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final GetAllHabits getAllHabits;
  final AddHabit addHabit;
  final UpdateHabit updateHabit;
  final DeleteHabit deleteHabit;
  final ToggleHabitCompletion toggleHabitCompletion;
  final GetHabitCompletions getHabitCompletions;

  HabitBloc({
    required this.getAllHabits,
    required this.addHabit,
    required this.updateHabit,
    required this.deleteHabit,
    required this.toggleHabitCompletion,
    required this.getHabitCompletions,
  }) : super(HabitInitial()) {
    on<LoadAllHabits>((event, emit) async {
      emit(HabitLoading());
      try {
        final habits = await getAllHabits();
        final selectedDate = DateTime.now();
        final completions = await getHabitCompletions(selectedDate);
        emit(HabitLoaded(habits, completions: completions, selectedDate: selectedDate));
      } catch (e) {
        emit(HabitError(e.toString()));
      }
    });
    on<AddHabitEvent>((event, emit) async {
      emit(HabitLoading());
      try {
        await addHabit(event.habit);
        final habits = await getAllHabits();
        final selectedDate = state is HabitLoaded ? (state as HabitLoaded).selectedDate : DateTime.now();
        final completions = await getHabitCompletions(selectedDate);
        emit(HabitLoaded(habits, completions: completions, selectedDate: selectedDate));
      } catch (e) {
        emit(HabitError(e.toString()));
      }
    });
    on<UpdateHabitEvent>((event, emit) async {
      emit(HabitLoading());
      try {
        await updateHabit(event.habit);
        final habits = await getAllHabits();
        final selectedDate = state is HabitLoaded ? (state as HabitLoaded).selectedDate : DateTime.now();
        final completions = await getHabitCompletions(selectedDate);
        emit(HabitLoaded(habits, completions: completions, selectedDate: selectedDate));
      } catch (e) {
        emit(HabitError(e.toString()));
      }
    });
    on<DeleteHabitEvent>((event, emit) async {
      emit(HabitLoading());
      try {
        await deleteHabit(event.id);
        final habits = await getAllHabits();
        final selectedDate = state is HabitLoaded ? (state as HabitLoaded).selectedDate : DateTime.now();
        final completions = await getHabitCompletions(selectedDate);
        emit(HabitLoaded(habits, completions: completions, selectedDate: selectedDate));
      } catch (e) {
        emit(HabitError(e.toString()));
      }
    });
    on<ToggleHabitCompletionEvent>((event, emit) async {
      try {
        await toggleHabitCompletion(event.habitId, event.date);
        final completions = await getHabitCompletions(event.date);
        if (state is HabitLoaded) {
          emit(HabitLoaded((state as HabitLoaded).habits, completions: completions, selectedDate: event.date));
        }
      } catch (e) {
        emit(HabitError(e.toString()));
      }
    });
    on<ChangeSelectedDate>((event, emit) async {
      emit(HabitLoading());
      try {
        final habits = await getAllHabits();
        final completions = await getHabitCompletions(event.selectedDate);
        emit(HabitLoaded(habits, completions: completions, selectedDate: event.selectedDate));
      } catch (e) {
        emit(HabitError(e.toString()));
      }
    });
    on<LoadHabitCompletionsEvent>((event, emit) async {
      try {
        final completions = await getHabitCompletions(event.date);
        emit(HabitCompletionsLoaded(completions));
      } catch (e) {
        emit(HabitError(e.toString()));
      }
    });
    on<ChangeCalendarFormat>((event, emit) async {
  if (state is HabitLoaded) {
    final s = state as HabitLoaded;
    emit(HabitLoaded(
      s.habits,
      completions: s.completions,
      selectedDate: s.selectedDate,
      calendarFormat: event.format,
    ));
  }
});
  }
} 
