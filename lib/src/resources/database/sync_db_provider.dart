import 'db_provider.dart';

class SyncDbProvider extends DbProvider {
  Future<bool> synced() async {
    final db = await database();
    List<Map> maps = await db
        .query('consumers', where: 'id IS NULL');
    return maps.length == 0;
  }

  Future<int> quantityNotSynchronized() async {
    final db = await database();
    List<Map> maps = await db
        .query('consumers', where: 'id IS NULL');
    return maps.length;
  }
}