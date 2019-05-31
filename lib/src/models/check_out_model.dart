class CheckOutModel {
  final double latitude;
  final double longitude;

  CheckOutModel({this.latitude, this.longitude,});

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
