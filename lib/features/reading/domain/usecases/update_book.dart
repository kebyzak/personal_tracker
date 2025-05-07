import '../entities/book.dart';
import '../repositories/reading_repository.dart';

class UpdateBook {
  final ReadingRepository repository;
  UpdateBook(this.repository);

  Future<void> call(Book book) {
    return repository.updateBook(book);
  }
} 
