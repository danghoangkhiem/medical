import 'package:meta/meta.dart';

import 'package:medical/src/models/place_model.dart';

@immutable
abstract class PlaceState {}

class Initial extends PlaceState {}

class Loading extends PlaceState {}

class Success extends PlaceState {
  final PlaceListModel places;

  Success({@required this.places});
}

class Failure extends PlaceState {
  final String error;

  Failure({@required this.error});
}
