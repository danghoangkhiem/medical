import 'dart:convert';

import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final int id;
  final String name;

  LocationModel({this.id, this.name}) : super([id, name]);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
