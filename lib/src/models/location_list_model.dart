import 'dart:collection';

import 'location_model.dart';

class LocationListModel extends ListMixin<LocationModel> {
  final List<LocationModel> _locations = List();

  int get length => _locations.length;

  set length(int length) => _locations.length = length;

  @override
  operator [](int index) {
    return _locations[index];
  }

  @override
  operator []=(int index, LocationModel value) {
    if (_locations.length == index) {
      _locations.add(value);
    } else {
      _locations[index] = value;
    }
  }

  LocationListModel.fromJson(List<dynamic> json) {
    List.from(json).forEach((item) {
      _locations.add(LocationModel.fromJson(item));
    });
  }

  List<dynamic> toJson() {
    List temp = [];
    List.from(_locations).forEach((item) {
      temp.add(item.toJson());
    });
    return temp;
  }
}
