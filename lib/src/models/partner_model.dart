import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'location_model.dart';

class PartnerModel extends Equatable {
  int id;
  String name;
  String role;
  String level;
  LocationModel location;

  PartnerModel({this.id, this.name, this.role, this.level, this.location})
      : super([id, name, role, level, location]);

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      id: json['id'] as int,
      name: json['name']?.toString(),
      role: json['role']?.toString(),
      level: json['level']?.toString(),
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
      'level': level,
      'location': location?.toJson(),
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
