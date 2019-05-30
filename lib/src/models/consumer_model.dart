import 'dart:collection';

import 'package:meta/meta.dart';

import 'additional_data_model.dart';

class ConsumerModel {
  final int id;
  final int locationId;
  final String name;
  final String phoneNumber;
  final String email;
  final DateTime dateOf;
  final DateTime createdAt;
  final ConsumerType type;
  final AdditionalDataModel additionalData;

  ConsumerModel({
    @required this.id,
    @required this.locationId,
    @required this.name,
    @required this.phoneNumber,
    this.email,
    this.dateOf,
    this.createdAt,
    this.type,
    this.additionalData,
  });

  ConsumerModel.fromJson(Map<String, dynamic> json)
      : assert(json != null),
        id = json['id'] as int,
        locationId = json['locationId'] as int,
        name = json['name'] as String,
        phoneNumber = json['phoneNumber'] as String,
        email = json['email'] as String,
        dateOf = DateTime.fromMillisecondsSinceEpoch(json['dateOf'] * 1000),
        createdAt =
            DateTime.fromMillisecondsSinceEpoch(json['createdAt'] * 1000),
        type = ConsumerType.from(json['type']),
        additionalData = AdditionalDataModel.fromJson(json['additionalData']);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'locationId': locationId,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'dateOf': dateOf.millisecondsSinceEpoch ~/ 1000,
      'createdAt': createdAt.millisecondsSinceEpoch ~/ 1000,
      'type': type.value,
      'additionalData': additionalData.toJson(),
    };
  }
}

class ConsumerListModel extends ListMixin<ConsumerModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  ConsumerModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, ConsumerModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  ConsumerListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(ConsumerModel.fromJson(element));
    });
  }

  List<dynamic> toJson() {
    return _list.map((element) => element.toJson()).toList();
  }
}

class ConsumerType {
  static const ConsumerType lead = ConsumerType._('lead');
  static const ConsumerType user = ConsumerType._('user');

  final String value;

  const ConsumerType._(this.value);

  factory ConsumerType.from(String type) {
    if (type == ConsumerType.lead.value) {
      return ConsumerType.lead;
    }
    if (type == ConsumerType.user.value) {
      return ConsumerType.user;
    }
    throw Exception('ConsumerType not found. Expected: '
        '${ConsumerType.lead}, '
        '${ConsumerType.user}');
  }

  @override
  String toString() => value;
}
