import 'dart:collection';

import 'additional.dart';
import 'invoice_item_model.dart';

class InvoiceModel {
  final int id;
  final InvoiceType type;
  final InvoiceStatus status;
  final DateTime date;
  final Map items;

  InvoiceModel({this.id, this.type, this.status, this.date, this.items});

  InvoiceModel.fromJson(Map<String, dynamic> json)
      : assert(json != null),
        id = json['id'] as int,
        type = InvoiceType.from(json['type']),
        date = DateTime.fromMillisecondsSinceEpoch(json['date']),
        status = InvoiceStatus.from(json['status']),
        items = _fromJsonInvoiceItemList(json['items']);

  static Map<Additional, List<InvoiceItemModel>> _fromJsonInvoiceItemList(
      Map<String, List> items) {
    return <Additional, List<InvoiceItemModel>>{
      Additional.samples:
        InvoiceItemListModel.fromJson(items[Additional.samples.value]),
      Additional.gifts:
        InvoiceItemListModel.fromJson(items[Additional.gifts.value]),
      Additional.pointOfSaleMaterials:
        InvoiceItemListModel.fromJson(
          items[Additional.pointOfSaleMaterials.value])
    };
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'type': type.value,
      'date': date.millisecondsSinceEpoch,
      'status': status.value,
      'items': {
        Additional.samples.value: items[Additional.samples].toJson(),
        Additional.gifts.value: items[Additional.gifts].toJson(),
        Additional.pointOfSaleMaterials.value:
          items[Additional.pointOfSaleMaterials].toJson(),
      }
    };
  }
}

class InvoiceListModel extends ListMixin<InvoiceModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  InvoiceModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, InvoiceModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  InvoiceListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(InvoiceModel.fromJson(element));
    });
  }

  List<dynamic> toJson() {
    return _list.map((element) => element.toJson()).toList();
  }
}

class InvoiceType {
  static const InvoiceType import = InvoiceType._('import');
  static const InvoiceType export = InvoiceType._('export');

  final String value;

  const InvoiceType._(this.value);

  factory InvoiceType.from(String type) {
    if (type == InvoiceType.import.value) {
      return InvoiceType.import;
    }
    if (type == InvoiceType.export.value) {
      return InvoiceType.export;
    }
    throw Exception(
        'Not found. Expected: ${InvoiceType.import}, ${InvoiceType.export}');
  }

  @override
  String toString() => value;
}

class InvoiceStatus {
  static const InvoiceStatus approved = InvoiceStatus._('approved');
  static const InvoiceStatus pending = InvoiceStatus._('pending');
  static const InvoiceStatus denied = InvoiceStatus._('denied');

  final String value;

  const InvoiceStatus._(this.value);

  factory InvoiceStatus.from(String status) {
    if (status == InvoiceStatus.approved.value) {
      return InvoiceStatus.approved;
    }
    if (status == InvoiceStatus.pending.value) {
      return InvoiceStatus.pending;
    }
    if (status == InvoiceStatus.denied.value) {
      return InvoiceStatus.denied;
    }
    throw Exception('Not found. Expected: '
        '${InvoiceStatus.approved}, '
        '${InvoiceStatus.pending}, '
        '${InvoiceStatus.denied}');
  }

  @override
  String toString() => value;
}
