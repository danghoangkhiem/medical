import 'dart:convert';
import 'dart:collection';

import 'package:equatable/equatable.dart';

import 'hours_model.dart';
import 'user_model.dart';
import 'partner_model.dart';

class ScheduleCoachingModel extends Equatable {
  int id;
  DateTime date;
  int scheduleId;
  UserModel user;
  PartnerModel partner;
  HoursModel hours;
  HoursModel realHours;
  String description;
  String evaluation;
  String feedback;

  ScheduleCoachingModel({
    this.id,
    this.date,
    this.scheduleId,
    this.user,
    this.partner,
    this.hours,
    this.realHours,
    this.description,
    this.evaluation,
    this.feedback,
  }) : super([
          id,
          date,
          scheduleId,
          user,
          partner,
          hours,
          realHours,
          description,
          evaluation,
          feedback,
        ]);

  factory ScheduleCoachingModel.fromJson(Map<String, dynamic> json) =>
      ScheduleCoachingModel(
        id: json['id'] as int,
        date: json['date'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000),
        scheduleId: json['scheduleId'] as int,
        user: json['user'] == null ? null : UserModel.fromJson(json['user']),
        partner: json['partner'] == null
            ? null
            : PartnerModel.fromJson(json['partner']),
        hours:
            json['hours'] == null ? null : HoursModel.fromJson(json['hours']),
        realHours: json['realHours'] == null
            ? null
            : HoursModel.fromJson(json['realHours']),
        description: json['description']?.toString(),
        evaluation: json['evaluation']?.toString(),
        feedback: json['feedback']?.toString(),
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'scheduleId': scheduleId,
      'user': user?.toJson(),
      'partner': partner?.toJson(),
      'hours': hours?.toJson(),
      'realHours': realHours?.toJson(),
      'description': description,
      'evaluation': evaluation,
      'feedback': feedback,
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
