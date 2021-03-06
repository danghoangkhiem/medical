import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:medical/src/models/check_in_model.dart';
import 'package:medical/src/models/check_out_model.dart';

abstract class CheckInEvent extends Equatable {
  CheckInEvent([List props = const []]) : super(props);
}

class AddCheckIn extends CheckInEvent {
  final CheckInModel newCheckInModel;

  AddCheckIn(this.newCheckInModel) : super([newCheckInModel]);

  @override
  String toString() => 'AddCheckIn { checkInModel: $newCheckInModel }';
}

class CheckIO extends CheckInEvent {
  @override
  String toString() => 'CheckIO';
}

class AddCheckOut extends CheckInEvent {
  final CheckOutModel newCheckOutModel;

  AddCheckOut(this.newCheckOutModel) : super([newCheckOutModel]);

  @override
  String toString() => 'AddCheckOut';
}

class Synchronize extends CheckInEvent {
  final bool isSynchronized;

  Synchronize({this.isSynchronized: false});
}
