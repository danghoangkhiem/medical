import 'dart:collection';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'additional_data_model.dart';

class ConsumerModel extends Equatable {
  int id;
  int locationId;
  String name;
  String phoneNumber;
  String email;
  DateTime expectedDateOfBirth;
  DateTime createdAt;
  int createdBy;
  ConsumerType type;
  AdditionalDataModel additionalData;
  String description;

  ConsumerModel({
    this.id,
    this.locationId,
    this.name,
    @required this.phoneNumber,
    this.email,
    this.expectedDateOfBirth,
    this.createdAt,
    this.createdBy,
    this.type,
    @required this.additionalData,
    this.description,
  }) : super([
          id,
          locationId,
          name,
          phoneNumber,
          email,
          expectedDateOfBirth,
          createdAt,
          createdBy,
          type,
          additionalData,
          description,
        ]);

  ConsumerModel.fromJson(Map<String, dynamic> json)
      : assert(json != null),
        id = json['id'] as int,
        locationId = json['locationId'] as int,
        name = json['name'] as String,
        phoneNumber = json['phoneNumber'] as String,
        email = json['email'] as String,
        expectedDateOfBirth =
            DateTime.fromMillisecondsSinceEpoch(json['edob'] * 1000),
        createdAt =
            DateTime.fromMillisecondsSinceEpoch(json['createdAt'] * 1000),
        createdBy = json['createdBy'] as int,
        type = ConsumerType.from(json['type']),
        additionalData = AdditionalDataModel.fromJson(json['additionalData']),
        description = json['description'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'locationId': locationId,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'edob': expectedDateOfBirth == null
          ? null
          : expectedDateOfBirth.millisecondsSinceEpoch ~/ 1000,
      'createdAt':
          createdAt == null ? null : createdAt.millisecondsSinceEpoch ~/ 1000,
      'createdBy': createdBy,
      'type': type?.value,
      'additionalData': additionalData?.toJson(),
      'description': description,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
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

  @override
  String toString() {
    return json.encode(toJson());
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
