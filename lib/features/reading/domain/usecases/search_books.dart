import '../entities/book.dart';
import '../repositories/reading_repository.dart';

class SearchBooks {
  final ReadingRepository repository;
  SearchBooks(this.repository);

  Future<List<Book>> call(String query) {
    return repository.searchBooks(query);
  }
} 
