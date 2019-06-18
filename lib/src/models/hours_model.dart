import 'dart:convert';

import 'package:equatable/equatable.dart';

class HoursModel extends Equatable {
  DateTime from;
  DateTime to;

  HoursModel({this.from, this.to}) : super([from, to]);

  factory HoursModel.fromJson(Map<String, dynamic> json) {
    return HoursModel(
      from: json['from'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['from'] + 1000),
      to: json['to'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['to'] + 1000),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'from': from == null ? null : from.millisecondsSinceEpoch ~/ 1000,
      'to': to == null ? null : to.millisecondsSinceEpoch ~/ 1000,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
