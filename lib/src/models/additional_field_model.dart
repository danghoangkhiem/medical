import 'dart:collection';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class AdditionalFieldModel extends Equatable {
  int key;
  Object value;
  String label;
  String image;

  AdditionalFieldModel(
      {@required this.key,
      @required this.value,
      @required this.label,
      this.image})
      : super([key, value, label, image]);

  AdditionalFieldModel.fromJson(Map<String, dynamic> json)
      : assert(json != null),
        key = json['key'] as int,
        value = json['value'] as Object,
        label = json['label'] as String,
        image = json['image'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'value': value,
      'label': label,
      'image': image,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
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

  void append(AdditionalFieldListModel appendedList) {
    appendedList.forEach((AdditionalFieldModel item) {
      int _index = _list.indexWhere((elem) => elem.key == item.key);
      if (_index > -1) {
        _list[_index] = AdditionalFieldModel.fromJson(item.toJson());
      } else {
        _list.add(AdditionalFieldModel.fromJson(item.toJson()));
      }
    });
  }

  AdditionalFieldListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(AdditionalFieldModel.fromJson(element));
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
