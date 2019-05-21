import 'dart:io';

class CheckInModel {
  final int locationId;
  final double lat;
  final double lon;
  final List<File> images;

  CheckInModel({this.locationId, this.lat, this.lon, this.images});

  Map<String, dynamic> toJson() {
    return {
      'locationId': locationId,
      'lat': lat,
      'lon': lon,
    };
  }
}
