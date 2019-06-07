import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'partner_model.dart';

class ScheduleWorkModel extends Equatable {
  int id;
  DateTime date;
  PartnerModel partner;

  ScheduleWorkModel({this.id, this.date, this.partner}) : super([]);
}