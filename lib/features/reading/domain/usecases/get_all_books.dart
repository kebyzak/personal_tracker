import '../entities/book.dart';
import '../repositories/reading_repository.dart';

class GetAllBooks {
  final ReadingRepository repository;
  GetAllBooks(this.repository);

  Future<List<Book>> call() {
    return repository.getAllBooks();
  }
} 
