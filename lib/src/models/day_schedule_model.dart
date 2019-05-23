import 'dart:collection';

class DayScheduleModel {
  final id;
  final DateTime startTime;
  final DateTime endTime;
  final String position;
  final String doctorName;
  final String addressType;
  final String addressName;

  DayScheduleModel(
      {this.id,
      this.startTime,
      this.endTime,
      this.position,
      this.doctorName,
      this.addressType,
      this.addressName});

  DayScheduleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        startTime = DateTime.fromMillisecondsSinceEpoch(json['startTime']),
        endTime = DateTime.fromMillisecondsSinceEpoch(json['endTime']),
        position = json['position'] as String,
        doctorName = json['doctorName'] as String,
        addressType = json['addressType'] as String,
        addressName = json['addressName'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'position': position,
      'doctorName': doctorName,
      'addressName': addressName,
      'addressType': addressType
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
