import 'dart:convert';
import 'dart:collection';

import 'package:equatable/equatable.dart';

import 'hours_model.dart';
import 'user_model.dart';

class ScheduleCoachingModel extends Equatable {
  int id;
  DateTime date;
  UserModel user;
  HoursModel hours;
  HoursModel realHours;
  ScheduleCoachingType status;
  String purpose;
  String description;

  ScheduleCoachingModel({
    this.id,
    this.date,
    this.user,
    this.hours,
    this.realHours,
    this.status,
    this.purpose,
    this.description,
  }) : super([
          id,
          date,
          user,
          hours,
          realHours,
          status,
          purpose,
          description,
        ]);

  factory ScheduleCoachingModel.fromJson(Map<String, dynamic> json) =>
      ScheduleCoachingModel(
        id: json['id'] as int,
        date: json['data'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000),
        user: UserModel.fromJson(json['user']),
        hours: HoursModel.fromJson(json['hours']),
        realHours: HoursModel.fromJson(json['realHours']),
        status: json['status'] == null
            ? null
            : ScheduleCoachingType.from(json['status']),
        purpose: json['purpose'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'user': user?.toJson(),
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

class ScheduleCoachingListModel extends ListMixin<ScheduleCoachingModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  ScheduleCoachingModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, ScheduleCoachingModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  ScheduleCoachingListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(ScheduleCoachingModel.fromJson(element));
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

class ScheduleCoachingType {
  static const ScheduleCoachingType later = ScheduleCoachingType._('later');
  static const ScheduleCoachingType meet = ScheduleCoachingType._('meet');
  static const ScheduleCoachingType notMeet = ScheduleCoachingType._('not_meet');

  final String value;

  const ScheduleCoachingType._(this.value);

  factory ScheduleCoachingType.from(String type) {
    if (type == ScheduleCoachingType.later.value) {
      return ScheduleCoachingType.later;
    }
    if (type == ScheduleCoachingType.meet.value) {
      return ScheduleCoachingType.meet;
    }
    if (type == ScheduleCoachingType.notMeet.value) {
      return ScheduleCoachingType.notMeet;
    }
    throw Exception('ScheduleCoachingType not found. Expected: '
        '${ScheduleCoachingType.later}, '
        '${ScheduleCoachingType.meet}, '
        '${ScheduleCoachingType.notMeet}');
  }

  @override
  String toString() => value;
}
