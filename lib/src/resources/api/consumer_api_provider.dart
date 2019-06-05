import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/consumer_model.dart';
import 'package:medical/src/models/additional_data_model.dart';

class ConsumerApiProvider extends ApiProvider {
  Future<ConsumerModel> createConsumer(ConsumerModel consumer) async {
    Response _resp =
        await httpClient.post('/consumers', data: consumer.toJson());
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
    Response _resp = await httpClient.get('/consumers',
        queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return ConsumerListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<AdditionalDataModel> getAdditionalFields() async {
    Response _resp = await httpClient.get('/consumers/additional-fields');
    if (_resp.statusCode == 200) {
      if (_resp.data['sameples'] != null) {
        _resp.data['samples'] = _resp.data['sameples'];
      }
      return AdditionalDataModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}