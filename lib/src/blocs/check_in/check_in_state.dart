import '../../models/location_list_model.dart';
import 'package:medical/src/models/coordinate_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:medical/src/models/attendance_model.dart';
import 'package:medical/src/models/location_list_model.dart';

abstract class CheckInState extends Equatable {
  CheckInState([List props = const []]) : super(props);
}

//start state checkIn
class CheckInInitial extends CheckInState {
  @override
  String toString() => 'CheckInInitial';
}

class CheckInLoading extends CheckInState {
  @override
  String toString() => 'CheckInLoading';
}

class CheckInLoaded extends CheckInState {
  final String message;

  CheckInLoaded({this.message}) : super([message]);

  @override
  String toString() => 'CheckInLoaded';
}

class CheckInFailure extends CheckInState {
  final String error;

  CheckInFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'CheckInFailure { error: $error }';
}
//end state checkIn

//start state checkIO
class CheckIOInitial extends CheckInState {
  @override
  String toString() => 'CheckIOInitial';
}

class CheckIOLoading extends CheckInState {
  @override
  String toString() => 'CheckIOLoading';
}

class CheckIOLoaded extends CheckInState {
  final bool isCheckIn;
  final AttendanceModel attendanceModel;
  final LocationListModel locationList;
  CheckIOLoaded({this.isCheckIn,this.attendanceModel,this.locationList}) : super([isCheckIn,attendanceModel,locationList]);

  @override
  String toString() => 'CheckIOLoaded';
}

class CheckIOFailure extends CheckInState {
  final String error;

  CheckIOFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'CheckIOFailure { error: $error }';
}
//end state checkIO


//start state checkIn
class CheckOutInitial extends CheckInState {
  @override
  String toString() => 'CheckOutInitial';
}

class CheckOutLoading extends CheckInState {
  @override
  String toString() => 'CheckOutLoading';
}

class CheckOutLoaded extends CheckInState {
  final String message;

  CheckOutLoaded({this.message}) : super([message]);

  @override
  String toString() => 'CheckOutLoaded';
}

class CheckOutFailure extends CheckInState {
  final String error;

  CheckOutFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'CheckOutFailure { error: $error }';
}
//end state checkIn

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

class CheckInError extends CheckInState {}

class CheckOutError extends CheckInState {}