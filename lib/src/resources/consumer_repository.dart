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

  Future<AdditionalDataModel> getAdditionalFields() async {
    return await _consumerApiProvider.getAdditionalFields();
  }

  Future<int> addConsumer(ConsumerModel consumer) async {
    return await _consumerDbProvider.addConsumer(consumer);
  }
}