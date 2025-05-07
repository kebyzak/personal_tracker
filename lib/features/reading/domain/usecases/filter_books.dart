import '../entities/book.dart';
import '../repositories/reading_repository.dart';

class FilterBooks {
  final ReadingRepository repository;
  FilterBooks(this.repository);

  Future<List<Book>> call({String? status, String? category, String? author}) {
    return repository.filterBooks(status: status, category: category, author: author);
  }
} 
