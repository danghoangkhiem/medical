import 'dart:collection';

import 'package:meta/meta.dart';

class AdditionalFieldModel {
  final int key;
  final int value;
  final String label;

  AdditionalFieldModel(
      {@required this.key, @required this.value, @required this.label});

  AdditionalFieldModel.fromJson(Map<String, dynamic> json)
      : assert(json != null),
        key = json['key'] as int,
        value = json['value'] as int,
        label = json['label'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'value': value,
      'label': label,
    };
  }
}

class AdditionalFieldListModel extends ListMixin<AdditionalFieldModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  AdditionalFieldModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, AdditionalFieldModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  AdditionalFieldListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(AdditionalFieldModel.fromJson(element));
    });
  }

  List<dynamic> toJson() {
    return _list.map((element) => element.toJson()).toList();
  }
}
