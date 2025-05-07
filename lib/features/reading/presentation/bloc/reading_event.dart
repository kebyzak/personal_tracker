import '../../domain/entities/book.dart';

abstract class ReadingEvent {}

class LoadAllBooks extends ReadingEvent {}
class AddBookEvent extends ReadingEvent {
  final Book book;
  AddBookEvent(this.book);
}
class UpdateBookEvent extends ReadingEvent {
  final Book book;
  UpdateBookEvent(this.book);
}
class DeleteBookEvent extends ReadingEvent {
  final int id;
  DeleteBookEvent(this.id);
}
class SearchBooksEvent extends ReadingEvent {
  final String query;
  SearchBooksEvent(this.query);
}
class FilterBooksEvent extends ReadingEvent {
  final String? status;
  final String? category;
  final String? author;
  FilterBooksEvent({this.status, this.category, this.author});
} 
