import '../../models/location_list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LocationState extends Equatable {
  LocationState([List props = const []]) : super(props);
}

class LocationInitial extends LocationState {
  @override
  String toString() => 'LocationInitial';
}

class LocationLoading extends LocationState {
  @override
  String toString() => 'LocationLoading';
}

class LocationLoaded extends LocationState {
  final LocationListModel locationList;

  LocationLoaded({@required this.locationList}) : super([locationList]);

  @override
  String toString() => 'LocationLoaded';
}

class LocationFailure extends LocationState {
  final String error;

  LocationFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LocationFailure { error: $error }';
}