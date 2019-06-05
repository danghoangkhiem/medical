import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'database/consumer_db_provider.dart';
import 'api/consumer_api_provider.dart';

import 'package:medical/src/models/consumer_model.dart';
import 'package:medical/src/models/additional_data_model.dart';

class ConsumerRepository {
  final ConsumerDbProvider _consumerDbProvider = ConsumerDbProvider();
  final ConsumerApiProvider _consumerApiProvider = ConsumerApiProvider();

  Future<ConsumerModel> findPhoneNumber(String phoneNumber) async {
    await Future.delayed(Duration(seconds: 1));
    return await _consumerDbProvider.findPhoneNumber(phoneNumber);
  }

  Future<ConsumerModel> getLastLocally() async {
    return await _consumerDbProvider.getLast();
  }

  Future<ConsumerListModel> getConsumerAccordingToOffset(
      {int offset = 0, int limit = 10}) async {
    return await _consumerApiProvider.getConsumerAccordingToOffset(
        offset: offset, limit: limit);
  }

  Future<AdditionalDataModel> getAdditionalFields() async {
    return await _consumerApiProvider.getAdditionalFields();
  }

  Future<AdditionalDataModel> getAdditionalFieldsLocally() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String additionalFieldsEncoded = prefs.getString('additionalFields');
    if (additionalFieldsEncoded == null) {
      return null;
    }
    return AdditionalDataModel.fromJson(json.decode(additionalFieldsEncoded));
  }

  Future<void> setAdditionalFieldsLocally(
      AdditionalDataModel additionalFields) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        'additionalFields', additionalFields.toString());
  }

  Future<bool> hasAdditionalFieldsLocally() async {
    final AdditionalDataModel additionalFields =
        await getAdditionalFieldsLocally();
    if (additionalFields != null) {
      return true;
    }
    return false;
  }

  Future<int> insertConsumerLocally(ConsumerModel consumer) async {
    return await _consumerDbProvider.insertConsumer(consumer);
  }

  Future<ConsumerModel> addConsumer(ConsumerModel consumer) async {
    return await _consumerApiProvider.addConsumer(consumer);
  }

  Future<int> addConsumerLocally(ConsumerModel consumer) async {
    return await _consumerDbProvider.addConsumer(consumer);
  }

  Future<int> setConsumerLocally(int _id, ConsumerModel consumer) async {
    return await _consumerDbProvider.setConsumerByPrimaryKey(_id, consumer);
  }

  Future<List<ConsumerModel>> getAll() async {
    return await _consumerDbProvider.getAll();
  }
}
