import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';

class InvoiceItemModel extends Equatable {
  final key;
  final String label;
  final int quantity;

  InvoiceItemModel({this.key, this.label, this.quantity})
      : super([key, label, quantity]);

  InvoiceItemModel.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        label = json['label'] as String,
        quantity = json['quantity'] as int;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'key': key, 'label': label, 'quantity': quantity};
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

class InvoiceItemListModel extends ListMixin<InvoiceItemModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  InvoiceItemModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, InvoiceItemModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  InvoiceItemListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(InvoiceItemModel.fromJson(element));
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
