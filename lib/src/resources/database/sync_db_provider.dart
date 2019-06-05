import 'dart:convert';

import 'db_provider.dart';

class SyncDbProvider extends DbProvider {
  int _currentNotSynchronizedPrimaryKey;

  int get currentNotSynchronizedPrimaryKey => _currentNotSynchronizedPrimaryKey;

  Future<bool> syncedByUserId(int userId) async {
    return await quantityNotSynchronizedByUserId(userId) == 0;
  }

  Future<int> quantityNotSynchronizedByUserId(int userId) async {
    final db = await database();
    List<Map> maps = await db.query(
      'consumers',
      where: 'id IS NULL AND createdBy = ?',
      whereArgs: [userId],
      columns: ['COUNT(_id) num'],
    );
    return maps.length == 0 ? 0 : maps.last['num'];
  }

  Future<Map<String, dynamic>> getNotSynchronizedByUserId(int userId) async {
    final db = await database();
    List<Map> maps = await db.query(
      'consumers',
      where: 'id IS NULL AND createdBy = ?',
      whereArgs: [userId],
      orderBy: '_id DESC',
      limit: 1,
    );
    if (maps.length == 0) {
      return null;
    }
    Map<String, dynamic> _consumer = Map.from(maps.last);
    _currentNotSynchronizedPrimaryKey = _consumer['_id'];
    _consumer['additionalData'] = json.decode(maps.last['additionalData']);
    return _consumer;
  }
}
