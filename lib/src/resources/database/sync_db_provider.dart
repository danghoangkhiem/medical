import 'db_provider.dart';

class SyncDbProvider extends DbProvider {
  Future<bool> synced() async {
    final db = await database();
    List<Map> maps = await db
        .query('consumers', where: '_rawId != 0');
    return maps.length == 0;
  }
}