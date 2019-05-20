import 'location_model.dart';
import 'dart:collection';

class LocationListModel extends ListMixin<LocationModel>{

  final List<LocationModel> _locations = List();

  int get length => _locations.length;

  set length(int length) => _locations.length = length;

  @override
  operator [](int id) {
    return _locations[id];
  }

  @override
  operator []=(int id, LocationModel value) {
    if(_locations.length == id){
      _locations.add(value);
    }
    else{
      _locations[id] = value;
    }
  }
}