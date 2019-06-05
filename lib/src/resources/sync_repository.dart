import 'database/sync_db_provider.dart';

class SyncRepository {
  final SyncDbProvider _syncDbProvider = SyncDbProvider();

  Future<bool> synced() async {
    return await _syncDbProvider.synced();
  }

  Future<int> quantityNotSynchronized() async {
    return await _syncDbProvider.quantityNotSynchronized();
  }

  Future<bool> syncedByUserId(int userId) async {
    return await _syncDbProvider.syncedByUserId(userId);
  }

  Future<int> quantityNotSynchronizedByUserId(int userId) async {
    return await _syncDbProvider.quantityNotSynchronizedByUserId(userId);
  }
}