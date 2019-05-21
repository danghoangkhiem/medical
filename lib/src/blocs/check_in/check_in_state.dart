import '../../models/location_list_model.dart';
import 'package:medical/src/models/coordinate_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:medical/src/models/check_in_model.dart';

abstract class CheckInState extends Equatable {
  CheckInState([List props = const []]) : super(props);
}

class CheckInInitial extends CheckInState {
  @override
  String toString() => 'CheckInInitial';
}

class CheckInLoading extends CheckInState {
  @override
  String toString() => 'CheckInLoading';
}

class CheckInLoaded extends CheckInState {
  final String title;

  CheckInLoaded({@required this.title}) : super([title]);

  @override
  String toString() => 'CheckInLoaded { title: $title }';
}

class CheckInFailure extends CheckInState {
  final String error;

  CheckInFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'CheckInFailure { error: $error }';
}

class CheckInLocationLoading extends CheckInState {
  @override
  String toString() => 'CheckInLocationLoading';
}

class CheckInLocationLoaded extends CheckInState {
  final LocationListModel locationList;
  final CoordinateModel coordinate;

  CheckInLocationLoaded({@required this.locationList,@required this.coordinate}) : super([locationList,coordinate]);

  @override
  String toString() => 'CheckInLoaded';
}

class CheckInLocationFailure extends CheckInState {
  final String error;

  CheckInLocationFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'CheckInFailure { error: $error }';
}