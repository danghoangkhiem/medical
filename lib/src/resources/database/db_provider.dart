import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  FutureOr<void> _onDatabaseCreate(Database db, int version) async {
    await db.execute('''
     CREATE TABLE `consumers` (
      `_id` INTEGER PRIMARY KEY AUTOINCREMENT,
      `_rawId` INTEGER NOT NULL,
      `id` INTEGER NOT NULL,
      `type` varchar(255) NOT NULL,
      `name` varchar(255) NOT NULL,
      `email` varchar(255) NOT NULL,
      `phoneNumber` varchar(13) NOT NULL,
      `locationId` int(10) NOT NULL,
      `edob` timestamp NULL DEFAULT NULL,
      `additionalData` text NOT NULL,
      `createdBy` INTEGER NOT NULL,
      `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
    );
    ''');
    // Indexes for table `consumers`
    await db.execute('''
    CREATE INDEX _rawId_index ON consumers (_rawId);
    CREATE INDEX id_index ON consumers (id);
    CREATE INDEX locationId_index ON consumers (locationId);
    CREATE INDEX phoneNumber_index ON consumers (phoneNumber);
    CREATE INDEX createdBy_index ON consumers (createdBy);
    CREATE INDEX type_index ON consumers (type);
    ''');
  }

  Future<Database> database() async {
    String dbFilename = 'medical.db';
    String dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, dbFilename),
        onCreate: _onDatabaseCreate, version: 1);
  }
}
