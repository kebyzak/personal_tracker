import 'package:drift/drift.dart';
import 'package:personal_tracker/core/data/database/app_database.dart';
import 'package:personal_tracker/features/reading/domain/entities/book.dart' as entity;

class ReadingLocalDataSource {
  final AppDatabase db;
  ReadingLocalDataSource(this.db);

  Future<List<entity.Book>> getAllBooks() async {
    final rows = await db.select(db.books).get();
    return rows.map<entity.Book>(_toBookEntity).toList();
  }

  Future<entity.Book?> getBookById(int id) async {
    final row = await (db.select(db.books)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toBookEntity(row);
  }

  Future<void> addBook(entity.Book book) async {
    await db.into(db.books).insert(
      BooksCompanion(
        title: Value(book.title),
        author: Value(book.author),
        coverImage: Value(book.coverImage),
        categories: Value(book.categories.join(',')),
        status: Value(book.status),
        currentPage: Value(book.currentPage),
        totalPages: Value(book.totalPages),
        rating: Value(book.rating),
        review: Value(book.review),
      ),
    );
  }

  Future<void> updateBook(entity.Book book) async {
    await (db.update(db.books)..where((tbl) => tbl.id.equals(book.id!))).write(
      BooksCompanion(
        title: Value(book.title),
        author: Value(book.author),
        coverImage: Value(book.coverImage),
        categories: Value(book.categories.join(',')),
        status: Value(book.status),
        currentPage: Value(book.currentPage),
        totalPages: Value(book.totalPages),
        rating: Value(book.rating),
        review: Value(book.review),
      ),
    );
  }

  Future<void> deleteBook(int id) async {
    await (db.delete(db.books)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<entity.Book>> searchBooks(String query) async {
    final rows = await (db.select(db.books)
      ..where((tbl) => tbl.title.like('%$query%') | tbl.author.like('%$query%'))).get();
    return rows.map<entity.Book>(_toBookEntity).toList();
  }

  Future<List<entity.Book>> filterBooks({String? status, String? category, String? author}) async {
    final query = db.select(db.books);
    if (status != null) {
      query.where((tbl) => tbl.status.equals(status));
    }
    if (category != null) {
      query.where((tbl) => tbl.categories.like('%$category%'));
    }
    if (author != null) {
      query.where((tbl) => tbl.author.equals(author));
    }
    final rows = await query.get();
    return rows.map<entity.Book>(_toBookEntity).toList();
  }

  entity.Book _toBookEntity(Book row) {
    return entity.Book(
      id: row.id,
      title: row.title,
      author: row.author,
      coverImage: row.coverImage,
      categories: row.categories.split(','),
      status: row.status,
      currentPage: row.currentPage,
      totalPages: row.totalPages,
      rating: row.rating,
      review: row.review,
    );
  }
} 
