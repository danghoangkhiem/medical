import 'db_provider.dart';

import 'package:medical/src/models/consumer_model.dart';

class ConsumerDbProvider extends DbProvider {
  Future<ConsumerModel> findPhoneNumber(String phoneNumber) async {
    final db = await database();
    List<Map> maps = await db
        .query('consumers', where: 'phoneNumber = ?', whereArgs: [phoneNumber]);
    if (maps.length == 0) {
      return null;
    }
    return ConsumerModel.fromJson(maps.last);
  }
}
