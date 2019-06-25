import 'dart:convert';
import 'dart:collection';

import 'package:equatable/equatable.dart';

import 'place_model.dart';

class PartnerModel extends Equatable {
  int id;
  String name;
  String role;
  String level;
  PlaceModel place;

  PartnerModel({this.id, this.name, this.role, this.level, this.place})
      : super([id, name, role, level, place]);

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      id: json['id'] as int,
      name: json['name']?.toString(),
      role: json['role']?.toString(),
      level: json['level']?.toString(),
      place: json['place'] == null
          ? null
          : PlaceModel.fromJson(json['place']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
      'level': level,
      'place': place?.toJson(),
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

class PartnerListModel extends ListMixin<PartnerModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  PartnerModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, PartnerModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  PartnerListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(PartnerModel.fromJson(element));
    });
  }

  List<dynamic> toJson() {
    return _list.map((element) => element.toJson()).toList();
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}