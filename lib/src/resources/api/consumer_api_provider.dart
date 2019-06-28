import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/consumer_model.dart';
import 'package:medical/src/models/additional_data_model.dart';
import 'package:medical/src/models/additional_field_model.dart';

class ConsumerApiProvider extends ApiProvider {
  Map<String, dynamic> _prepareConsumerData(ConsumerModel consumer) {
    final ConsumerModel _consumer = ConsumerModel.fromJson(consumer.toJson());
    final Function _predicate =
        (AdditionalFieldModel item) => item.value == null;
    _consumer.additionalData.samples.removeWhere(_predicate);
    _consumer.additionalData.gifts.removeWhere(_predicate);
    _consumer.additionalData.purchases.removeWhere(_predicate);
    _consumer.additionalData.pointOfSaleMaterials.removeWhere(_predicate);
    return _consumer.toJson()..remove('id');
  }

  Future<ConsumerModel> addConsumer(ConsumerModel consumer) async {
    Map<String, dynamic> _requestBody = _prepareConsumerData(consumer);
    Response _resp = await httpClient.post('/consumers', data: _requestBody);
    if (_resp.statusCode == 200) {
      return ConsumerModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<ConsumerListModel> getConsumerAccordingToOffset(
      {int offset = 0, int limit = 10}) async {
    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
    };
    Response _resp =
        await httpClient.get('/consumers', queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return ConsumerListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<ConsumerListModel> getConsumerList(
      {int offset = 0, int limit = 10, int idGreaterThan, String sort}) async {
    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
      'idGreaterThan': idGreaterThan,
      'sort': sort,
    };
    Response _resp =
    await httpClient.get('/consumers', queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return ConsumerListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<AdditionalDataModel> getAdditionalFields() async {
    Response _resp = await httpClient.get('/consumers/additional-fields');
    if (_resp.statusCode == 200) {
      return AdditionalDataModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
