import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:medical/src/models/check_in_model.dart';

abstract class CheckInEvent extends Equatable {
  CheckInEvent([List props = const []]) : super(props);
}

class AddCheckIn extends CheckInEvent {
  final CheckInModel newCheckInModel;

  AddCheckIn(this.newCheckInModel) : super([newCheckInModel]);

  @override
  String toString() => 'AddCheckIn { checkInModel: $newCheckInModel }';
}
