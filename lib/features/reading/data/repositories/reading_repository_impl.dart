import '../../domain/entities/book.dart';
import '../../domain/repositories/reading_repository.dart';
import '../datasources/reading_local_datasource.dart';

class ReadingRepositoryImpl implements ReadingRepository {
  final ReadingLocalDataSource localDataSource;
  ReadingRepositoryImpl(this.localDataSource);

  @override
  Future<List<Book>> getAllBooks() => localDataSource.getAllBooks();

  @override
  Future<Book?> getBookById(int id) => localDataSource.getBookById(id);

  @override
  Future<void> addBook(Book book) => localDataSource.addBook(book);

  @override
  Future<void> updateBook(Book book) => localDataSource.updateBook(book);

  @override
  Future<void> deleteBook(int id) => localDataSource.deleteBook(id);

  @override
  Future<List<Book>> searchBooks(String query) => localDataSource.searchBooks(query);

  @override
  Future<List<Book>> filterBooks({String? status, String? category, String? author}) =>
      localDataSource.filterBooks(status: status, category: category, author: author);
} 
