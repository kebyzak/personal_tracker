import '../entities/book.dart';

abstract class ReadingRepository {
  Future<List<Book>> getAllBooks();
  Future<Book?> getBookById(int id);
  Future<void> addBook(Book book);
  Future<void> updateBook(Book book);
  Future<void> deleteBook(int id);
  Future<List<Book>> searchBooks(String query);
  Future<List<Book>> filterBooks({String? status, String? category, String? author});
} 
