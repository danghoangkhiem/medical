import 'dart:convert';

import 'db_provider.dart';

import 'package:medical/src/models/consumer_model.dart';
import 'package:medical/src/models/customer_manage_model.dart';

class ConsumerDbProvider extends DbProvider {
  Future<ConsumerModel> findPhoneNumber(String phoneNumber) async {
    final db = await database();
    List<Map> maps = await db.query(
      'consumers',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
      limit: 1,
      orderBy: '_id DESC',
    );
    if (maps.length == 0) {
      return null;
    }
    Map<String, dynamic> consumer = Map.from(maps.last);
    consumer['additionalData'] = json.decode(maps.last['additionalData']);
    return ConsumerModel.fromJson(consumer);
  }

  Future<ConsumerModel> getLast() async {
    final db = await database();
    List<Map> maps = await db.query(
      'consumers',
      limit: 1,
      orderBy: 'id DESC',
    );
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
    values.remove('id');
    values['additionalData'] = json.encode(values['additionalData']);
    List<Map> maps = await db.query(
      'consumers',
      columns: ['_id', 'id'],
      where: 'id IS NULL AND phoneNumber = ?',
      whereArgs: [consumer.phoneNumber],
      limit: 1,
      orderBy: '_id DESC',
    );
    if (maps.length > 0) {
      return await db.update('consumers', values,
          where: '_id = ?', whereArgs: [maps.last['_id']]);
    }
    return await db.insert('consumers', values);
  }

  Future<int> insertConsumer(ConsumerModel consumer) async {
    final db = await database();
    final Map<String, dynamic> values = consumer.toJson();
    values['additionalData'] = json.encode(values['additionalData']);
    return await db.insert('consumers', values);
  }

  Future<int> setConsumerByPrimaryKey(int _id, ConsumerModel consumer) async {
    final db = await database();
    final Map values = consumer.toJson();
    values['additionalData'] = json.encode(values['additionalData']);
    return await db
        .update('consumers', values, where: '_id = ?', whereArgs: [_id]);
  }

  Future<ConsumerListModel> getListConsumerByPhoneNumber(
    String phoneNumber, {
    int offset = 0,
    int limit = 20,
  }) async {
    final db = await database();
    List<Map> maps = await db.query(
      'consumers',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
      limit: limit,
      offset: offset,
    );
    if (maps.length == 0) {
      return ConsumerListModel.fromJson([]);
    }
    return ConsumerListModel.fromJson(maps.map((item) {
      Map<String, dynamic> consumer = Map.from(item);
      consumer['additionalData'] = json.decode(item['additionalData']);
      return consumer;
    }).toList());
  }

  Future<List<ConsumerModel>> getAll() async {
    final db = await database();
    List<Map> maps = await db.query('consumers');
    if (maps.length == 0) {
      return [];
    }
    return maps.map((item) {
      Map<String, dynamic> consumer = Map.from(item);
      consumer['additionalData'] = json.decode(item['additionalData']);
      return ConsumerModel.fromJson(consumer);
    }).toList();
  }

  Future<CustomerManagerListModel> getListCustomer(
      int timeIn, int userId, int offset, int limit, String type) async {
    print(offset);
    print(limit);
    final db = await database();
    List<Map> maps = await db.query('consumers',
        where: 'createdBy = ? ',
        whereArgs: [userId],
        limit: limit,
        offset: offset);
    print(maps);
    if (maps.length == 0) {
      return null;
    }
    return CustomerManagerListModel.fromJson(maps.map((item) {
      return {
        "id": item['id'],
        "name": item['name'],
        "phone": item['phoneNumber'],
      };
    }).toList());
  }

  Future<void> truncateTable() async {
    final db = await database();
    await db.execute('DELETE FROM consumers');
  }
}
