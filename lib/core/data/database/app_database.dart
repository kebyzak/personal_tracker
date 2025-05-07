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

@DriftDatabase(tables: [Books])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.sqlite'));
    return NativeDatabase(file);
  });
} 
