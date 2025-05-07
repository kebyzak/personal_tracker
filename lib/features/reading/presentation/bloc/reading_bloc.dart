import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_book.dart';
import '../../domain/usecases/get_all_books.dart';
import '../../domain/usecases/update_book.dart';
import '../../domain/usecases/delete_book.dart';
import '../../domain/usecases/search_books.dart';
import '../../domain/usecases/filter_books.dart';
import 'reading_event.dart';
import 'reading_state.dart';

class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  final GetAllBooks getAllBooks;
  final AddBook addBook;
  final UpdateBook updateBook;
  final DeleteBook deleteBook;
  final SearchBooks searchBooks;
  final FilterBooks filterBooks;

  ReadingBloc({
    required this.getAllBooks,
    required this.addBook,
    required this.updateBook,
    required this.deleteBook,
    required this.searchBooks,
    required this.filterBooks,
  }) : super(ReadingInitial()) {
    on<LoadAllBooks>((event, emit) async {
      emit(ReadingLoading());
      try {
        final books = await getAllBooks();
        emit(ReadingLoaded(books));
      } catch (e) {
        emit(ReadingError(e.toString()));
      }
    });
    on<AddBookEvent>((event, emit) async {
      emit(ReadingLoading());
      try {
        await addBook(event.book);
        final books = await getAllBooks();
        emit(ReadingLoaded(books));
      } catch (e) {
        emit(ReadingError(e.toString()));
      }
    });
    on<UpdateBookEvent>((event, emit) async {
      emit(ReadingLoading());
      try {
        await updateBook(event.book);
        final books = await getAllBooks();
        emit(ReadingLoaded(books));
      } catch (e) {
        emit(ReadingError(e.toString()));
      }
    });
    on<DeleteBookEvent>((event, emit) async {
      emit(ReadingLoading());
      try {
        await deleteBook(event.id);
        final books = await getAllBooks();
        emit(ReadingLoaded(books));
      } catch (e) {
        emit(ReadingError(e.toString()));
      }
    });
    on<SearchBooksEvent>((event, emit) async {
      emit(ReadingLoading());
      try {
        final books = await searchBooks(event.query);
        emit(ReadingLoaded(books));
      } catch (e) {
        emit(ReadingError(e.toString()));
      }
    });
    on<FilterBooksEvent>((event, emit) async {
      emit(ReadingLoading());
      try {
        final books = await filterBooks(
          status: event.status,
          category: event.category,
          author: event.author,
        );
        emit(ReadingLoaded(books));
      } catch (e) {
        emit(ReadingError(e.toString()));
      }
    });
  }
}
