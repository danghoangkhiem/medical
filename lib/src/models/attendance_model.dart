import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'location_model.dart';

class AttendanceModel extends Equatable {
  final int id;
  final LocationModel location;
  final DateTime timeIn;
  final DateTime timeOut;

  AttendanceModel({this.id, this.location, this.timeIn, this.timeOut})
      : super([id, location, timeIn, timeOut]);

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    AttendanceModel _instance = AttendanceModel(
      id: json['id'],
      location: LocationModel.fromJson(json['location']),
      timeIn: _dateTimeFromUnix(json['timeIn']),
      timeOut: _dateTimeFromUnix(json['timeOut']),
    );
    return _instance;
  }

  static int _unixFromDateTime(DateTime date) {
    return date != null ? date.millisecondsSinceEpoch ~/ 1000 : null;
  }

  static DateTime _dateTimeFromUnix(int timestamp) {
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
        : null;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'location': location?.toJson(),
      'timeIn': _unixFromDateTime(timeIn),
      'timeOut': _unixFromDateTime(timeOut),
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

class AttendanceListModel extends ListMixin<AttendanceModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  AttendanceModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, AttendanceModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  AttendanceListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(AttendanceModel.fromJson(element));
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
