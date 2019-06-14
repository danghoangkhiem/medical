import 'dart:convert';
import 'dart:collection';

import 'package:equatable/equatable.dart';

import 'hours_model.dart';
import 'place_model.dart';

class SchedulePlaceModel extends Equatable {
  int id;
  DateTime date;
  PlaceModel place;
  HoursModel hours;
  HoursModel realHours;
  SchedulePlaceType status;
  String purpose;
  String description;

  SchedulePlaceModel({
    this.id,
    this.date,
    this.place,
    this.hours,
    this.realHours,
    this.status,
    this.purpose,
    this.description,
  }) : super([
          id,
          date,
          place,
          hours,
          realHours,
          status,
          purpose,
          description,
        ]);

  factory SchedulePlaceModel.fromJson(Map<String, dynamic> json) =>
      SchedulePlaceModel(
        id: json['id'] as int,
        date: json['data'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000),
        place: PlaceModel.fromJson(json['place']),
        hours: HoursModel.fromJson(json['hours']),
        realHours: HoursModel.fromJson(json['realHours']),
        status: json['status'] == null
            ? null
            : SchedulePlaceType.from(json['status']),
        purpose: json['purpose'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'place': place?.toJson(),
      'hours': hours?.toJson(),
      'realHours': realHours?.toJson(),
      'status': status?.value,
      'purpose': purpose,
      'description': description,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

class SchedulePlaceListModel extends ListMixin<SchedulePlaceModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  SchedulePlaceModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, SchedulePlaceModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  SchedulePlaceListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(SchedulePlaceModel.fromJson(element));
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

class SchedulePlaceType {
  static const SchedulePlaceType later = SchedulePlaceType._('later');
  static const SchedulePlaceType meet = SchedulePlaceType._('meet');
  static const SchedulePlaceType notMeet = SchedulePlaceType._('not_meet');

  final String value;

  const SchedulePlaceType._(this.value);

  factory SchedulePlaceType.from(String type) {
    if (type == SchedulePlaceType.later.value) {
      return SchedulePlaceType.later;
    }
    if (type == SchedulePlaceType.meet.value) {
      return SchedulePlaceType.meet;
    }
    if (type == SchedulePlaceType.notMeet.value) {
      return SchedulePlaceType.notMeet;
    }
    throw Exception('SchedulePlaceType not found. Expected: '
        '${SchedulePlaceType.later}, '
        '${SchedulePlaceType.meet}, '
        '${SchedulePlaceType.notMeet}');
  }

  @override
  String toString() => value;
}
