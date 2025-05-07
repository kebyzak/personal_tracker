// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverImageMeta =
      const VerificationMeta('coverImage');
  @override
  late final GeneratedColumn<String> coverImage = GeneratedColumn<String>(
      'cover_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoriesMeta =
      const VerificationMeta('categories');
  @override
  late final GeneratedColumn<String> categories = GeneratedColumn<String>(
      'categories', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentPageMeta =
      const VerificationMeta('currentPage');
  @override
  late final GeneratedColumn<int> currentPage = GeneratedColumn<int>(
      'current_page', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalPagesMeta =
      const VerificationMeta('totalPages');
  @override
  late final GeneratedColumn<int> totalPages = GeneratedColumn<int>(
      'total_pages', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _reviewMeta = const VerificationMeta('review');
  @override
  late final GeneratedColumn<String> review = GeneratedColumn<String>(
      'review', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        author,
        coverImage,
        categories,
        status,
        currentPage,
        totalPages,
        rating,
        review
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(Insertable<Book> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('cover_image')) {
      context.handle(
          _coverImageMeta,
          coverImage.isAcceptableOrUnknown(
              data['cover_image']!, _coverImageMeta));
    }
    if (data.containsKey('categories')) {
      context.handle(
          _categoriesMeta,
          categories.isAcceptableOrUnknown(
              data['categories']!, _categoriesMeta));
    } else if (isInserting) {
      context.missing(_categoriesMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('current_page')) {
      context.handle(
          _currentPageMeta,
          currentPage.isAcceptableOrUnknown(
              data['current_page']!, _currentPageMeta));
    }
    if (data.containsKey('total_pages')) {
      context.handle(
          _totalPagesMeta,
          totalPages.isAcceptableOrUnknown(
              data['total_pages']!, _totalPagesMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('review')) {
      context.handle(_reviewMeta,
          review.isAcceptableOrUnknown(data['review']!, _reviewMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      coverImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_image']),
      categories: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categories'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      currentPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_page'])!,
      totalPages: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_pages'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating'])!,
      review: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review']),
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class Book extends DataClass implements Insertable<Book> {
  final int id;
  final String title;
  final String author;
  final String? coverImage;
  final String categories;
  final String status;
  final int currentPage;
  final int totalPages;
  final double rating;
  final String? review;
  const Book(
      {required this.id,
      required this.title,
      required this.author,
      this.coverImage,
      required this.categories,
      required this.status,
      required this.currentPage,
      required this.totalPages,
      required this.rating,
      this.review});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    if (!nullToAbsent || coverImage != null) {
      map['cover_image'] = Variable<String>(coverImage);
    }
    map['categories'] = Variable<String>(categories);
    map['status'] = Variable<String>(status);
    map['current_page'] = Variable<int>(currentPage);
    map['total_pages'] = Variable<int>(totalPages);
    map['rating'] = Variable<double>(rating);
    if (!nullToAbsent || review != null) {
      map['review'] = Variable<String>(review);
    }
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      title: Value(title),
      author: Value(author),
      coverImage: coverImage == null && nullToAbsent
          ? const Value.absent()
          : Value(coverImage),
      categories: Value(categories),
      status: Value(status),
      currentPage: Value(currentPage),
      totalPages: Value(totalPages),
      rating: Value(rating),
      review:
          review == null && nullToAbsent ? const Value.absent() : Value(review),
    );
  }

  factory Book.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      coverImage: serializer.fromJson<String?>(json['coverImage']),
      categories: serializer.fromJson<String>(json['categories']),
      status: serializer.fromJson<String>(json['status']),
      currentPage: serializer.fromJson<int>(json['currentPage']),
      totalPages: serializer.fromJson<int>(json['totalPages']),
      rating: serializer.fromJson<double>(json['rating']),
      review: serializer.fromJson<String?>(json['review']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'coverImage': serializer.toJson<String?>(coverImage),
      'categories': serializer.toJson<String>(categories),
      'status': serializer.toJson<String>(status),
      'currentPage': serializer.toJson<int>(currentPage),
      'totalPages': serializer.toJson<int>(totalPages),
      'rating': serializer.toJson<double>(rating),
      'review': serializer.toJson<String?>(review),
    };
  }

  Book copyWith(
          {int? id,
          String? title,
          String? author,
          Value<String?> coverImage = const Value.absent(),
          String? categories,
          String? status,
          int? currentPage,
          int? totalPages,
          double? rating,
          Value<String?> review = const Value.absent()}) =>
      Book(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        coverImage: coverImage.present ? coverImage.value : this.coverImage,
        categories: categories ?? this.categories,
        status: status ?? this.status,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
        rating: rating ?? this.rating,
        review: review.present ? review.value : this.review,
      );
  Book copyWithCompanion(BooksCompanion data) {
    return Book(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      coverImage:
          data.coverImage.present ? data.coverImage.value : this.coverImage,
      categories:
          data.categories.present ? data.categories.value : this.categories,
      status: data.status.present ? data.status.value : this.status,
      currentPage:
          data.currentPage.present ? data.currentPage.value : this.currentPage,
      totalPages:
          data.totalPages.present ? data.totalPages.value : this.totalPages,
      rating: data.rating.present ? data.rating.value : this.rating,
      review: data.review.present ? data.review.value : this.review,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('coverImage: $coverImage, ')
          ..write('categories: $categories, ')
          ..write('status: $status, ')
          ..write('currentPage: $currentPage, ')
          ..write('totalPages: $totalPages, ')
          ..write('rating: $rating, ')
          ..write('review: $review')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, author, coverImage, categories,
      status, currentPage, totalPages, rating, review);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.coverImage == this.coverImage &&
          other.categories == this.categories &&
          other.status == this.status &&
          other.currentPage == this.currentPage &&
          other.totalPages == this.totalPages &&
          other.rating == this.rating &&
          other.review == this.review);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String?> coverImage;
  final Value<String> categories;
  final Value<String> status;
  final Value<int> currentPage;
  final Value<int> totalPages;
  final Value<double> rating;
  final Value<String?> review;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.categories = const Value.absent(),
    this.status = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.rating = const Value.absent(),
    this.review = const Value.absent(),
  });
  BooksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String author,
    this.coverImage = const Value.absent(),
    required String categories,
    required String status,
    this.currentPage = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.rating = const Value.absent(),
    this.review = const Value.absent(),
  })  : title = Value(title),
        author = Value(author),
        categories = Value(categories),
        status = Value(status);
  static Insertable<Book> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? coverImage,
    Expression<String>? categories,
    Expression<String>? status,
    Expression<int>? currentPage,
    Expression<int>? totalPages,
    Expression<double>? rating,
    Expression<String>? review,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (coverImage != null) 'cover_image': coverImage,
      if (categories != null) 'categories': categories,
      if (status != null) 'status': status,
      if (currentPage != null) 'current_page': currentPage,
      if (totalPages != null) 'total_pages': totalPages,
      if (rating != null) 'rating': rating,
      if (review != null) 'review': review,
    });
  }

  BooksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? author,
      Value<String?>? coverImage,
      Value<String>? categories,
      Value<String>? status,
      Value<int>? currentPage,
      Value<int>? totalPages,
      Value<double>? rating,
      Value<String?>? review}) {
    return BooksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverImage: coverImage ?? this.coverImage,
      categories: categories ?? this.categories,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      rating: rating ?? this.rating,
      review: review ?? this.review,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (coverImage.present) {
      map['cover_image'] = Variable<String>(coverImage.value);
    }
    if (categories.present) {
      map['categories'] = Variable<String>(categories.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (currentPage.present) {
      map['current_page'] = Variable<int>(currentPage.value);
    }
    if (totalPages.present) {
      map['total_pages'] = Variable<int>(totalPages.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (review.present) {
      map['review'] = Variable<String>(review.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('coverImage: $coverImage, ')
          ..write('categories: $categories, ')
          ..write('status: $status, ')
          ..write('currentPage: $currentPage, ')
          ..write('totalPages: $totalPages, ')
          ..write('rating: $rating, ')
          ..write('review: $review')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTable books = $BooksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [books];
}

typedef $$BooksTableCreateCompanionBuilder = BooksCompanion Function({
  Value<int> id,
  required String title,
  required String author,
  Value<String?> coverImage,
  required String categories,
  required String status,
  Value<int> currentPage,
  Value<int> totalPages,
  Value<double> rating,
  Value<String?> review,
});
typedef $$BooksTableUpdateCompanionBuilder = BooksCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> author,
  Value<String?> coverImage,
  Value<String> categories,
  Value<String> status,
  Value<int> currentPage,
  Value<int> totalPages,
  Value<double> rating,
  Value<String?> review,
});

class $$BooksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BooksTable,
    Book,
    $$BooksTableFilterComposer,
    $$BooksTableOrderingComposer,
    $$BooksTableCreateCompanionBuilder,
    $$BooksTableUpdateCompanionBuilder> {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BooksTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BooksTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<String?> coverImage = const Value.absent(),
            Value<String> categories = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> currentPage = const Value.absent(),
            Value<int> totalPages = const Value.absent(),
            Value<double> rating = const Value.absent(),
            Value<String?> review = const Value.absent(),
          }) =>
              BooksCompanion(
            id: id,
            title: title,
            author: author,
            coverImage: coverImage,
            categories: categories,
            status: status,
            currentPage: currentPage,
            totalPages: totalPages,
            rating: rating,
            review: review,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String author,
            Value<String?> coverImage = const Value.absent(),
            required String categories,
            required String status,
            Value<int> currentPage = const Value.absent(),
            Value<int> totalPages = const Value.absent(),
            Value<double> rating = const Value.absent(),
            Value<String?> review = const Value.absent(),
          }) =>
              BooksCompanion.insert(
            id: id,
            title: title,
            author: author,
            coverImage: coverImage,
            categories: categories,
            status: status,
            currentPage: currentPage,
            totalPages: totalPages,
            rating: rating,
            review: review,
          ),
        ));
}

class $$BooksTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get author => $state.composableBuilder(
      column: $state.table.author,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get coverImage => $state.composableBuilder(
      column: $state.table.coverImage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get categories => $state.composableBuilder(
      column: $state.table.categories,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get currentPage => $state.composableBuilder(
      column: $state.table.currentPage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get totalPages => $state.composableBuilder(
      column: $state.table.totalPages,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get rating => $state.composableBuilder(
      column: $state.table.rating,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get review => $state.composableBuilder(
      column: $state.table.review,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$BooksTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get author => $state.composableBuilder(
      column: $state.table.author,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get coverImage => $state.composableBuilder(
      column: $state.table.coverImage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get categories => $state.composableBuilder(
      column: $state.table.categories,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get currentPage => $state.composableBuilder(
      column: $state.table.currentPage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get totalPages => $state.composableBuilder(
      column: $state.table.totalPages,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get rating => $state.composableBuilder(
      column: $state.table.rating,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get review => $state.composableBuilder(
      column: $state.table.review,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
}
