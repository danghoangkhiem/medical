import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int id;
  final String name;
  final String code;

  @JsonKey(fromJson: _roleFromJson, toJson: _roleToJson)
  final UserRoleType role;

  UserModel({this.id, this.name, this.code, this.role})
      : super([id, name, code, role]);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static UserRoleType _roleFromJson(String role) {
    if (role == 'MED_SUP') {
      return UserRoleType.MedicalSupervisor;
    }
    if (role == 'MED_REP') {
      return UserRoleType.MedicalRepresentative;
    }
    return UserRoleType.MedicalNutritionRepresentative;
  }

  static String _roleToJson(UserRoleType role) {
    if (role == UserRoleType.MedicalSupervisor) {
      return 'MED_SUP';
    }
    if (role == UserRoleType.MedicalRepresentative) {
      return 'MED_REP';
    }
    return 'NUTRI_REP';
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

enum UserRoleType {
  MedicalNutritionRepresentative,
  MedicalRepresentative,
  MedicalSupervisor
}
