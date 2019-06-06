import 'dart:collection';

class CustomerManagerModel {
  final id;
  final String name;
  final String phone;

  CustomerManagerModel({this.id, this.name, this.phone});

  CustomerManagerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] as String,
        phone = json['phoneNumber'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name, 'phoneNumber': phone};
  }
}

class CustomerManagerListModel extends ListMixin<CustomerManagerModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  CustomerManagerModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, CustomerManagerModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  CustomerManagerListModel.fromJson(List json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(CustomerManagerModel.fromJson(element));
    });
  }

  List<dynamic> toJson() {
    return _list.map((element) => element.toJson()).toList();
  }
}


class CustomerType{
  static const CustomerType leadType = CustomerType._('lead');
  static const CustomerType userType = CustomerType._('user');

  final String value;

  const CustomerType._(this.value);

  @override
  String toString() => value;
}

class CustomerStatus{
  static const CustomerStatus oldStatus = CustomerStatus._('old');
  static const CustomerStatus newStatus = CustomerStatus._('new');
  static const CustomerStatus receiveStatus = CustomerStatus._('receive');

  final String value;

  const CustomerStatus._(this.value);

  @override
  String toString() => value;
}