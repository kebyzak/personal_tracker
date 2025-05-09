import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'app_database.g.dart';

class Books extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get coverImage => text().nullable()();
  TextColumn get categories => text()(); // comma-separated
  TextColumn get status => text()(); // 'to_read', 'reading', 'completed', 'abandoned'
  IntColumn get currentPage => integer().withDefault(const Constant(0))();
  IntColumn get totalPages => integer().withDefault(const Constant(0))();
  RealColumn get rating => real().withDefault(const Constant(0.0))();
  TextColumn get review => text().nullable()();
}

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get emoji => text()();
  TextColumn get daysOfWeek => text()(); // comma-separated, e.g. "1,3,5"
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get startDate => dateTime()();
}

class HabitCompletions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Books, Habits, HabitCompletions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Add migrations here when you need to update the schema
        if (from < 2) {
          // Example migration for future schema changes
          // await m.addColumn(books, books.newColumn);
        }
      },
      beforeOpen: (details) async {
        // This is called before the database is opened
        // You can use this to verify the database integrity
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Get the application documents directory
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'personal_tracker.db'));
    
    // Make sure the directory exists
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }

    // Check if database exists, if not create it
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    
    return NativeDatabase(
      file,
      setup: (db) {
        // Enable foreign keys
        db.execute('PRAGMA foreign_keys = ON');
        // Enable WAL mode for better concurrency
        db.execute('PRAGMA journal_mode = WAL');
      },
    );
  });
} 
 