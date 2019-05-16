import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  AttendanceEvent([List props = const []]) : super(props);
}

class GetCatalog extends AttendanceEvent {}