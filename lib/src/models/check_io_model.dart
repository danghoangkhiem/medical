import 'package:medical/src/models/location_model.dart';

class CheckIOModel {
  final int id;
  final LocationModel location;
  final int timeIn;
  final int timeOut;

  CheckIOModel({this.id, this.location, this.timeIn, this.timeOut});

  factory CheckIOModel.fromJson(Map<String, dynamic> json) {
    return CheckIOModel(
        id: json["id"],
        location: LocationModel.fromJson(json["location"]),
        timeIn: json["timeIn"],
        timeOut: json["timeOut"]);
  }
}
