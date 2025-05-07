import '../../domain/entities/book.dart';

abstract class ReadingState {}

class ReadingInitial extends ReadingState {}
class ReadingLoading extends ReadingState {}
class ReadingLoaded extends ReadingState {
  final List<Book> books;
  ReadingLoaded(this.books);
}
class ReadingError extends ReadingState {
  final String message;
  ReadingError(this.message);
} 
