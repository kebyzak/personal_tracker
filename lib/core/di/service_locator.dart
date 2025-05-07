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

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Data sources
  sl.registerLazySingleton<ReadingLocalDataSource>(() => ReadingLocalDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<ReadingRepositoryImpl>(() => ReadingRepositoryImpl(sl()));
  sl.registerLazySingleton<ReadingRepository>(() => ReadingRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton<GetAllBooks>(() => GetAllBooks(sl()));
  sl.registerLazySingleton<AddBook>(() => AddBook(sl()));
  sl.registerLazySingleton<UpdateBook>(() => UpdateBook(sl()));
  sl.registerLazySingleton<DeleteBook>(() => DeleteBook(sl()));
  sl.registerLazySingleton<SearchBooks>(() => SearchBooks(sl()));
  sl.registerLazySingleton<FilterBooks>(() => FilterBooks(sl()));

  // BLoCs
  sl.registerFactory<ReadingBloc>(() => ReadingBloc(
    getAllBooks: sl(),
    addBook: sl(),
    updateBook: sl(),
    deleteBook: sl(),
    searchBooks: sl(),
    filterBooks: sl(),
  ));
} 
