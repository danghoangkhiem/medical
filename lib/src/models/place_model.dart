import 'dart:convert';
import 'dart:collection';

import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  final int id;
  final String name;

  PlaceModel({this.id, this.name}) : super([id, name]);

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
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

class PlaceListModel extends ListMixin<PlaceModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  PlaceModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, PlaceModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  PlaceListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(PlaceModel.fromJson(element));
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