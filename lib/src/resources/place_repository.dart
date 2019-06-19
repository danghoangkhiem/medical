import 'api/place_api_provider.dart';

import 'package:medical/src/models/place_model.dart';
import 'package:medical/src/models/partner_model.dart';

class PlaceRepository {
  final PlaceApiProvider _placeApiProvider = PlaceApiProvider();

  Future<PlaceListModel> places({int offset = 0, int limit = 20}) async {
    return await _placeApiProvider.places(offset: offset, limit: limit);
  }

  Future<PartnerListModel> partnersAccordingToPlace(
    int placeId, {
    int offset = 0,
    int limit = 20,
  }) async {
    return await _placeApiProvider.partnersAccordingToPlace(
      placeId,
      offset: offset,
      limit: limit,
    );
  }
}
