import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  FutureOr<void> _onDatabaseCreate(Database db, int version) async {
    await db.execute('CREATE TABLE locations (id INTEGER PRIMARY KEY, name TEXT)');
  }

  Future<Database> database() async {
    String dbFilename = 'database.db';
    String dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, dbFilename),
        onCreate: _onDatabaseCreate, version: 1);
  }
}
