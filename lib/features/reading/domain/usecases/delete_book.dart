import '../repositories/reading_repository.dart';

class DeleteBook {
  final ReadingRepository repository;
  DeleteBook(this.repository);

  Future<void> call(int id) {
    return repository.deleteBook(id);
  }
} 
