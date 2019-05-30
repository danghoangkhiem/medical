import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/location_list_model.dart';
import 'package:medical/src/models/location_model.dart';

class LocationApiProvider extends ApiProvider {
  Future<LocationListModel> getLocations() async {
    Response _resp = await httpClient.get('/locations');
    if (_resp.statusCode == 200) {
      return LocationListModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data['error']));
  }
}
