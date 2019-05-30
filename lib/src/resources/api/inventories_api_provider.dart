import 'package:medical/src/resources/api/api_response_error.dart';
import 'package:meta/meta.dart';

import 'api_provider.dart';

import '../../models/models.dart';

class InventoriesApiProvider extends ApiProvider {

  Future<InventoriesModel> getInventories({@required DateTime startDate,@required DateTime endDate, int value}) async {
    //await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> _queryParameters = {
      'startDate':
      DateTime(startDate.year, startDate.month, startDate.day, 00, 00, 00)
          .millisecondsSinceEpoch ~/
          1000,
      'endDate':
      DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59)
          .millisecondsSinceEpoch ~/
          1000,
      'type': value
    };

    Response _resp = await httpClient.get('/inventories',
        queryParameters: _queryParameters);

    if (_resp.statusCode == 200) {
      return InventoriesModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data['error']));

  }

}



