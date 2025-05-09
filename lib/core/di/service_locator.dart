import 'package:get_it/get_it.dart';
import '../../features/reading/domain/repositories/reading_repository.dart';
import '../data/database/app_database.dart';
import '../../features/reading/data/datasources/reading_local_datasource.dart';
import '../../features/reading/data/repositories/reading_repository_impl.dart';
import '../../features/reading/domain/usecases/get_all_books.dart';
import '../../features/reading/domain/usecases/add_book.dart';
import '../../features/reading/domain/usecases/update_book.dart';
import '../../features/reading/domain/usecases/delete_book.dart';
import '../../features/reading/domain/usecases/search_books.dart';
import '../../features/reading/domain/usecases/filter_books.dart';
import '../../features/reading/presentation/bloc/reading_bloc.dart';
// Habit imports
import '../../features/habits/data/datasources/habit_local_datasource.dart';
import '../../features/habits/data/repositories/habit_repository_impl.dart';
import '../../features/habits/domain/repositories/habit_repository.dart';
import '../../features/habits/domain/usecases/add_habit.dart';
import '../../features/habits/presentation/bloc/habit_bloc.dart';
import '../../features/habits/domain/usecases/get_all_habits.dart';
import '../../features/habits/domain/usecases/update_habit.dart';
import '../../features/habits/domain/usecases/delete_habit.dart';
import '../../features/habits/data/datasources/habit_completion_local_datasource.dart';
import '../../features/habits/data/repositories/habit_completion_repository_impl.dart';
import '../../features/habits/domain/repositories/habit_completion_repository.dart';
import '../../features/habits/domain/usecases/toggle_habit_completion.dart';
import '../../features/habits/domain/usecases/get_habit_completions.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Data sources
  sl.registerLazySingleton<ReadingLocalDataSource>(() => ReadingLocalDataSource(sl()));
  sl.registerLazySingleton<HabitLocalDataSource>(() => HabitLocalDataSource(sl()));
  sl.registerLazySingleton<HabitCompletionLocalDataSource>(() => HabitCompletionLocalDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<ReadingRepositoryImpl>(() => ReadingRepositoryImpl(sl()));
  sl.registerLazySingleton<ReadingRepository>(() => ReadingRepositoryImpl(sl()));
  sl.registerLazySingleton<HabitRepositoryImpl>(() => HabitRepositoryImpl(sl()));
  sl.registerLazySingleton<HabitRepository>(() => HabitRepositoryImpl(sl()));
  sl.registerLazySingleton<HabitCompletionRepositoryImpl>(() => HabitCompletionRepositoryImpl(sl()));
  sl.registerLazySingleton<HabitCompletionRepository>(() => HabitCompletionRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton<GetAllBooks>(() => GetAllBooks(sl()));
  sl.registerLazySingleton<AddBook>(() => AddBook(sl()));
  sl.registerLazySingleton<UpdateBook>(() => UpdateBook(sl()));
  sl.registerLazySingleton<DeleteBook>(() => DeleteBook(sl()));
  sl.registerLazySingleton<SearchBooks>(() => SearchBooks(sl()));
  sl.registerLazySingleton<FilterBooks>(() => FilterBooks(sl()));
  sl.registerLazySingleton<GetAllHabits>(() => GetAllHabits(sl()));
  sl.registerLazySingleton<AddHabit>(() => AddHabit(sl()));
  sl.registerLazySingleton<UpdateHabit>(() => UpdateHabit(sl()));
  sl.registerLazySingleton<DeleteHabit>(() => DeleteHabit(sl()));
  sl.registerLazySingleton<ToggleHabitCompletion>(() => ToggleHabitCompletion(sl()));
  sl.registerLazySingleton<GetHabitCompletions>(() => GetHabitCompletions(sl()));

  // BLoCs
  sl.registerFactory<ReadingBloc>(() => ReadingBloc(
    getAllBooks: sl(),
    addBook: sl(),
    updateBook: sl(),
    deleteBook: sl(),
    searchBooks: sl(),
    filterBooks: sl(),
  ));
  sl.registerFactory<HabitBloc>(() => HabitBloc(
    getAllHabits: sl(),
    addHabit: sl(),
    updateHabit: sl(),
    deleteHabit: sl(),
    toggleHabitCompletion: sl(),
    getHabitCompletions: sl(),
  ));
} 
