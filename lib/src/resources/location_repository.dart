import 'package:medical/src/models/location_list_model.dart';
class LocationRepository {
  Future<LocationListModel> getLocations() async {
    await Future.delayed(Duration(seconds: 1));
    return LocationListModel.fromJson([
        {'id' : 1,'name': "TPHCM"},
        {'id' : 2,'name': "BINHDUONG"},
      ]);
  }
}
