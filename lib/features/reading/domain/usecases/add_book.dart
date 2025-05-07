import '../entities/book.dart';
import '../repositories/reading_repository.dart';

class AddBook {
  final ReadingRepository repository;
  AddBook(this.repository);

  Future<void> call(Book book) {
    return repository.addBook(book);
  }
} 
