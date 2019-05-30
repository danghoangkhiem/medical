import 'package:medical/src/models/location_list_model.dart';
import 'package:medical/src/resources/api/location_api_provider.dart';

class LocationRepository {
  final LocationApiProvider _locationApiProvider = LocationApiProvider();

  Future<LocationListModel> getLocations() async {
    return await _locationApiProvider.getLocations();
  }
}
