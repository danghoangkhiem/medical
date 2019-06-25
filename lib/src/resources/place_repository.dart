import 'api/place_api_provider.dart';

import 'package:medical/src/models/place_model.dart';
import 'package:medical/src/models/partner_model.dart';

class PlaceRepository {
  final PlaceApiProvider _placeApiProvider = PlaceApiProvider();

  Future<PlaceListModel> places({int offset = 0, int limit = 20}) async {
    await Future.delayed(Duration(seconds: 1));
    return PlaceListModel.fromJson([
      {
        'id': 1,
        'name': 'Địa bàn 1'
      },
      {
        'id': 2,
        'name': 'Địa bàn 2'
      }
    ]);
    return await _placeApiProvider.places(offset: offset, limit: limit);
  }

  Future<PartnerListModel> partnersAccordingToPlace(
    int placeId, {
    int offset = 0,
    int limit = 20,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return PartnerListModel.fromJson([
      {
        "id": 1,
        "name": "Nguyễn Văn A",
        "role": "BS",
        "level": "A",
        "place": {
          "id": 14,
          "name": "Bệnh viện 115",
          "type": "Bệnh viện"
        }
      },
      {
        "id": 2,
        "name": "Nguyễn Văn B",
        "role": "BS",
        "level": "B",
        "place": {
          "id": 14,
          "name": "Bệnh viện 115",
          "type": "Bệnh viện"
        }
      },
      {
        "id": 3,
        "name": "Nguyễn Văn C",
        "role": "BS",
        "level": "C",
        "place": {
          "id": 14,
          "name": "Bệnh viện 115",
          "type": "Bệnh viện"
        }
      },
    ]);
    return await _placeApiProvider.partnersAccordingToPlace(
      placeId,
      offset: offset,
      limit: limit,
    );
  }
}
