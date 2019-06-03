import 'database/sync_db_provider.dart';

class SyncRepository {
  final SyncDbProvider _syncDbProvider = SyncDbProvider();

  Future<bool> synced() async {
    return await _syncDbProvider.synced();
  }

  Future<int> quantityNotSynchronized() async {
    return await _syncDbProvider.quantityNotSynchronized();
  }
}