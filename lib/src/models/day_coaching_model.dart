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
      : id = json['id'],
        startTime = DateTime.fromMillisecondsSinceEpoch(json['startTime']),
        endTime = DateTime.fromMillisecondsSinceEpoch(json['endTime']),
        realStartTime =
            DateTime.fromMillisecondsSinceEpoch(json['realStartTime']),
        realEndTime = DateTime.fromMillisecondsSinceEpoch(json['realEndTime']),
        position = json['position'] as String,
        doctorName = json['doctorName'] as String,
        addressType = json['addressType'] as String,
        addressName = json['addressName'] as String,
        description = json['description'] as String,
        evaluate = json['evaluate'] as String,
        feedback = json['feedback'] as String;

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
