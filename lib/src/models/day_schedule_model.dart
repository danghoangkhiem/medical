import 'dart:collection';

class DayScheduleModel {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final String role;
  final String doctorName;
  final String location;
  final DateTime realStartTime;
  final DateTime realEndTime;
  final DayScheduleStatus status;
  final String purpose;
  final String description;

  DayScheduleModel(
      {this.id,
      this.startTime,
      this.endTime,
      this.role,
      this.doctorName,
      this.location,
      this.realStartTime,
      this.realEndTime,
      this.status,
      this.purpose,
      this.description});

  DayScheduleModel.fromJson(Map<String, dynamic> json)
      : /*id = json['id'],
        startTime = DateTime.fromMillisecondsSinceEpoch(json['startTime']),
        endTime = DateTime.fromMillisecondsSinceEpoch(json['endTime']),
        position = json['position'] as String,
        doctorName = json['doctorName'] as String,
        addressType = json['addressType'] as String,
        addressName = json['addressName'] as String,
        realStartTime = DateTime.fromMillisecondsSinceEpoch(json['realStartTime']),
        realEndTime = DateTime.fromMillisecondsSinceEpoch(json['realEndTime']),
        status = DayScheduleStatus.from( json['status']),
        purpose = json['purpose'] as String,
        description = json['description'] as String;*/

        id = json['id'],
        startTime = DateTime.fromMillisecondsSinceEpoch(json['hours']['from']*1000),
        endTime = DateTime.fromMillisecondsSinceEpoch(json['hours']['end']*1000),
        role = json['partner'] == null ? "" : json['partner']['role'] as String,
        doctorName = json['partner'] == null ? "" : json['partner']['name'] as String,
        location = json['partner'] == null ? "" : json['partner']['location']['name'] as String,
        realStartTime = json['realHours']['from'] == null ? DateTime.fromMillisecondsSinceEpoch(json['hours']['from']*1000) : DateTime.fromMillisecondsSinceEpoch(json['realHours']['from']*1000),
        realEndTime = json['realHours']['end'] == null ? DateTime.fromMillisecondsSinceEpoch(json['hours']['end']*1000) : DateTime.fromMillisecondsSinceEpoch(json['realHours']['end']*1000),
        status = DayScheduleStatus.from(json['status']),
        purpose =  json['purpose'] as String,
        description = json['description'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'position': role,
      'doctorName': doctorName,
      'location': location,
      'realStartTime': realStartTime,
      'realEndTime': realEndTime,
      'status': status.value,
      'purpose': purpose,
      'description': description,
    };
  }
}

class DayScheduleListModel extends ListMixin<DayScheduleModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  DayScheduleModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, DayScheduleModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  DayScheduleListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(DayScheduleModel.fromJson(element));
    });
  }

  List<dynamic> toJson() {
    return _list.map((element) => element.toJson()).toList();
  }
}

class DayScheduleStatus {
  static const DayScheduleStatus later = DayScheduleStatus._('later');
  static const DayScheduleStatus notMet = DayScheduleStatus._('not_meet');
  static const DayScheduleStatus met = DayScheduleStatus._('meet');

  final String value;

  const DayScheduleStatus._(this.value);

  factory DayScheduleStatus.from(String status) {
    if (status == DayScheduleStatus.later.value) {
      return DayScheduleStatus.later;
    }
    if (status == DayScheduleStatus.notMet.value) {
      return DayScheduleStatus.notMet;
    }
    if (status == DayScheduleStatus.met.value) {
      return DayScheduleStatus.met;
    }
    throw Exception('Not found. Expected: '
        '${DayScheduleStatus.later}, '
        '${DayScheduleStatus.notMet}, '
        '${DayScheduleStatus.met}');
  }

  @override
  String toString() => value;
}

