import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/customer_manage_model.dart';

class CustomerApiProvider extends ApiProvider {
  Future<CustomerManagerListModel> getCustomerByTypeAndStatus(
      {int timeIn,
      int offset = 0,
      int limit = 10,
      @required String type,
      @required String status}) async {
    Map<String, dynamic> _queryParameters = {
      'timeIn': timeIn,
      'offset': offset,
      'limit': limit,
      'type': type,
      'status': status,
    };
    Response _resp =
        await httpClient.get('/consumers', queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return CustomerManagerListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
