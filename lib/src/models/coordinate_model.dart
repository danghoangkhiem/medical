class CoordinateModel {
  final double lat;
  final double lon;

  CoordinateModel({this.lat, this.lon});

  factory CoordinateModel.fromJson(Map<String, dynamic> json) {
    return CoordinateModel(lat: json["lat"], lon: json["lon"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}