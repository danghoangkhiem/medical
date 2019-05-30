import 'dart:collection';

import 'event_type.dart';
import 'invoice_item_model.dart';

class InvoiceModel {
  final int id;
  final InvoiceType type;
  final InvoiceStatus status;
  final DateTime date;
  final String owner;
  final Map items;

  InvoiceModel(
      {this.id, this.type, this.status, this.date, this.owner, this.items});

  InvoiceModel.fromJson(Map<String, dynamic> json)
      : assert(json != null),
        id = json['id'] as int,
        type = InvoiceType.from(json['type']),
        date = DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000),
        owner = json['owner'],
        status = InvoiceStatus.from(json['status']),
        items = _fromJsonInvoiceItemList(json['items']);

  static Map<EventType, List<InvoiceItemModel>> _fromJsonInvoiceItemList(
      Map<String, dynamic> items) {
    return <EventType, List<InvoiceItemModel>>{
      EventType.samples:
          InvoiceItemListModel.fromJson(items[EventType.samples.value]),
      EventType.purchases:
          InvoiceItemListModel.fromJson(items[EventType.purchases.value]),
      EventType.gifts:
          InvoiceItemListModel.fromJson(items[EventType.gifts.value]),
      EventType.pointOfSaleMaterials: InvoiceItemListModel.fromJson(
          items[EventType.pointOfSaleMaterials.value])
    };
  }

  static Map<String, dynamic> _toJsonInvoiceItemList(
      Map<EventType, InvoiceItemModel> items) {
    return <String, dynamic>{
      EventType.samples.value: items[EventType.samples].toJson(),
      EventType.gifts.value: items[EventType.gifts].toJson(),
      EventType.purchases.value: items[EventType.purchases].toJson(),
      EventType.pointOfSaleMaterials.value:
          items[EventType.pointOfSaleMaterials].toJson(),
    };
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'type': type.value,
      'date': date.millisecondsSinceEpoch,
      'owner': owner,
      'status': status.value,
      'items': _toJsonInvoiceItemList(items),
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
    throw Exception('InvoiceType not found. Expected: '
        '${InvoiceType.import}, '
        '${InvoiceType.export}');
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
    throw Exception('InvoiceStatus not found. Expected: '
        '${InvoiceStatus.approved}, '
        '${InvoiceStatus.pending}, '
        '${InvoiceStatus.denied}');
  }

  @override
  String toString() => value;
}
