import '../../models/location_list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CheckInState extends Equatable {
  CheckInState([List props = const []]) : super(props);
}

class CheckInInitial extends CheckInState {
  @override
  String toString() => 'CheckInInitial';
}

class CheckInLocationLoading extends CheckInState {
  @override
  String toString() => 'CheckInLocationLoading';
}

class CheckInLocationLoaded extends CheckInState {
  final LocationListModel locationList;

  CheckInLocationLoaded({@required this.locationList}) : super([locationList]);

  @override
  String toString() => 'CheckInLoaded';
}

class CheckInLocationFailure extends CheckInState {
  final String error;

  CheckInLocationFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'CheckInFailure { error: $error }';
}