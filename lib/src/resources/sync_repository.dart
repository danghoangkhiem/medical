import 'database/sync_db_provider.dart';

class SyncRepository {
  final SyncDbProvider _syncDbProvider = SyncDbProvider();

  int get currentNotSynchronizedId => _syncDbProvider.currentNotSynchronizedId;

  Future<bool> syncedByUserId(int userId) async {
    return await _syncDbProvider.syncedByUserId(userId);
  }

  Future<int> quantityNotSynchronizedByUserId(int userId) async {
    return await _syncDbProvider.quantityNotSynchronizedByUserId(userId);
  }

  Future<Map<String, dynamic>> getNotSynchronizedByUserId(int userId) async {
    return await _syncDbProvider.getNotSynchronizedByUserId(userId);
  }
}
