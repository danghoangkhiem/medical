import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/place_model.dart';
import 'package:medical/src/models/partner_model.dart';

class PlaceApiProvider extends ApiProvider {
  Future<PlaceListModel> places({
    int offset = 0,
    int limit = 20,
  }) async {
    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
    };
    Response _resp =
        await httpClient.get('/places', queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return PlaceListModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<PartnerListModel> partnersAccordingToPlace(
    int placeId, {
    int offset = 0,
    int limit = 20,
  }) async {
    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
    };
    Response _resp = await httpClient.get('/places/$placeId/partners',
        queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return PartnerListModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
