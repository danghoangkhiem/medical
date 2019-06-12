import 'dart:collection';

class DayCoachingModel {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime realStartTime;
  final DateTime realEndTime;

  final String position;
  final String doctorName;
  final String addressType;
  final String addressName;

  final String description;
  final String evaluate;
  final String feedback;

  DayCoachingModel(
      {this.id,
      this.startTime,
      this.endTime,
      this.realStartTime,
      this.realEndTime,
      this.position,
      this.doctorName,
      this.addressType,
      this.addressName,
      this.description,
      this.evaluate,
      this.feedback});

  DayCoachingModel.fromJson(Map<String, dynamic> json)
      : /*id = json['id'],
        startTime = DateTime.fromMillisecondsSinceEpoch(json['hours']['from']),
        endTime = DateTime.fromMillisecondsSinceEpoch(json['hours']['end']),
        realStartTime =
            DateTime.fromMillisecondsSinceEpoch(json['realHours']['from']),
        realEndTime = DateTime.fromMillisecondsSinceEpoch(json['realHours']['end']),
        position = json['partner']['position'] as String,
        doctorName = (json['partner']['first_name'] + ' ' + json['partner']['last_name']) as String,
        addressType = json['partner']['department'] as String,
        addressName = json['partner']['department'] as String,
        description = json['description'] as String,
        evaluate = json['purpose'] as String,
        feedback = json['purpose'] as String;*/

        id = json['id'],
        startTime = DateTime.fromMillisecondsSinceEpoch(json['hours']['from']),
        endTime = DateTime.fromMillisecondsSinceEpoch(json['hours']['end']),
        realStartTime = json['realHours']['from'] == null ? DateTime.fromMillisecondsSinceEpoch(json['hours']['from']) : DateTime.fromMillisecondsSinceEpoch(json['realHours']['from']),
        realEndTime = json['realHours']['end'] == null ? DateTime.fromMillisecondsSinceEpoch(json['hours']['end']) : DateTime.fromMillisecondsSinceEpoch(json['realHours']['end']),
        position = json['partner'] == null ? "" : json['partner']['position'] as String,
        doctorName = json['partner'] == null ? "" : (json['partner']['first_name'] + json['partner']['last_name']) as String,
        addressType = "not api",
        addressName = "not api",
        description = json['description'] as String,
        evaluate = "not api",
        feedback = "not api";

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
      'description': description,
      'evaluate': evaluate,
      'feedback': feedback,
    };
  }
}

class DayCoachingListModel extends ListMixin<DayCoachingModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  DayCoachingModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, DayCoachingModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  DayCoachingListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(DayCoachingModel.fromJson(element));
    });
  }

  List<dynamic> toJson() {
    return _list.map((element) => element.toJson()).toList();
  }
}
