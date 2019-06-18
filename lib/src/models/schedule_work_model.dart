import 'dart:convert';
import 'dart:collection';

import 'package:equatable/equatable.dart';

import 'hours_model.dart';
import 'partner_model.dart';

class ScheduleWorkModel extends Equatable {
  int id;
  DateTime date;
  PartnerModel partner;
  HoursModel hours;
  HoursModel realHours;
  ScheduleWorkType status;
  String purpose;
  String description;

  ScheduleWorkModel({
    this.id,
    this.date,
    this.partner,
    this.hours,
    this.realHours,
    this.status,
    this.purpose,
    this.description,
  }) : super([
          id,
          date,
          partner,
          hours,
          realHours,
          status,
          purpose,
          description,
        ]);

  factory ScheduleWorkModel.fromJson(Map<String, dynamic> json) =>
      ScheduleWorkModel(
        id: json['id'] as int,
        date: json['date'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000),
        partner: json['partner'] == null
            ? null
            : PartnerModel.fromJson(json['partner']),
        hours:
            json['hours'] == null ? null : HoursModel.fromJson(json['hours']),
        realHours: json['realHours'] == null
            ? null
            : HoursModel.fromJson(json['realHours']),
        status: json['status'] == null
            ? null
            : ScheduleWorkType.from(json['status']),
        purpose: json['purpose'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'date': date != null ? date.millisecondsSinceEpoch ~/ 1000 : null,
      'partner': partner?.toJson(),
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

class ScheduleWorkListModel extends ListMixin<ScheduleWorkModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  ScheduleWorkModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, ScheduleWorkModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  ScheduleWorkListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(ScheduleWorkModel.fromJson(element));
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

class ScheduleWorkType {
  static const ScheduleWorkType later = ScheduleWorkType._('later');
  static const ScheduleWorkType meet = ScheduleWorkType._('meet');
  static const ScheduleWorkType notMeet = ScheduleWorkType._('not_meet');

  final String value;

  const ScheduleWorkType._(this.value);

  factory ScheduleWorkType.from(String type) {
    if (type == ScheduleWorkType.later.value) {
      return ScheduleWorkType.later;
    }
    if (type == ScheduleWorkType.meet.value) {
      return ScheduleWorkType.meet;
    }
    if (type == ScheduleWorkType.notMeet.value) {
      return ScheduleWorkType.notMeet;
    }
    throw Exception('ScheduleWorkType not found. Expected: '
        '${ScheduleWorkType.later}, '
        '${ScheduleWorkType.meet}, '
        '${ScheduleWorkType.notMeet}');
  }

  @override
  String toString() => value;
}
