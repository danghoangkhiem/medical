import 'dart:collection';

class DayScheduleModel {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final String position;
  final String doctorName;
  final String addressType;
  final String addressName;
  final DateTime realStartTime;
  final DateTime realEndTime;
  final DayScheduleStatus status;
  final String purpose;
  final String description;

  DayScheduleModel(
      {this.id,
      this.startTime,
      this.endTime,
      this.position,
      this.doctorName,
      this.addressType,
      this.addressName,
      this.realStartTime,
      this.realEndTime,
      this.status,
      this.purpose,
      this.description});

  DayScheduleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
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
        description = json['description'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'position': position,
      'doctorName': doctorName,
      'addressName': addressName,
      'addressType': addressType,
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
  static const DayScheduleStatus notMet = DayScheduleStatus._('not_met');
  static const DayScheduleStatus met = DayScheduleStatus._('met');

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

