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
    if (role == 'med') {
      return UserRoleType.Med;
    }
    if (role == 'leader') {
      return UserRoleType.Leader;
    }
    return UserRoleType.Nutri;
  }

  static String _roleToJson(UserRoleType role) {
    if (role == UserRoleType.Med) {
      return 'med';
    }
    if (role == UserRoleType.Leader) {
      return 'leader';
    }
    return 'nutri';
  }
}

enum UserRoleType { Nutri, Med, Leader }
