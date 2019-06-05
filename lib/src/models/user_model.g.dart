// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
      id: json['id'] as int,
      name: json['name'].toString(),
      code: json['code'].toString(),
      role: json['role'] == null
          ? null
          : UserModel._roleFromJson(json['role'] as String));
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'role':
          instance.role == null ? null : UserModel._roleToJson(instance.role)
    };
