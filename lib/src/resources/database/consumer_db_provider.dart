import 'dart:convert';

import 'db_provider.dart';

import 'package:medical/src/models/consumer_model.dart';
import 'package:medical/src/models/customer_manage_model.dart';

class ConsumerDbProvider extends DbProvider {
  Future<ConsumerModel> findPhoneNumber(String phoneNumber) async {
    final db = await database();
    List<Map> maps = await db
        .query('consumers', where: 'phoneNumber = ?', whereArgs: [phoneNumber]);
    if (maps.length == 0) {
      return null;
    }
    Map<String, dynamic> consumer = Map.from(maps.last);
    consumer['additionalData'] = json.decode(maps.last['additionalData']);
    return ConsumerModel.fromJson(consumer);
  }

  Future<int> addConsumer(ConsumerModel consumer) async {
    final db = await database();
    final purchaseList = consumer.additionalData.purchases
        .where((item) =>
            item.value != null && int.parse(item.value.toString()) > 0)
        .toList();
    consumer.type =
        purchaseList.length > 0 ? ConsumerType.user : ConsumerType.lead;
    final Map values = consumer.toJson();
    values['additionalData'] = json.encode(values['additionalData']);
    return await db.insert('consumers', values);
  }

  Future<CustomerManagerListModel> getListCustomer(int timeIn, int userId, int offset, int limit, String type) async {
    print(offset);
    print(limit);
    final db = await database();
    List<Map> maps = await db
        .query('consumers', where: 'createdBy = ? ',whereArgs: [userId],limit: limit,offset: offset);
    print(maps);
    if (maps.length == 0) {
      return null;
    }
    return CustomerManagerListModel.fromJson(maps.map((item){
      return {
        "id": item['id'],
        "name": item['name'],
        "phone": item['phoneNumber'],
      };
    }).toList());
  }
}
