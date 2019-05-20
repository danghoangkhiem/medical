import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CheckInEvent extends Equatable {
  CheckInEvent([List props = const []]) : super(props);
}
//
class GetLocation extends CheckInEvent {

  GetLocation() : super();

  @override
  String toString() {
    return "Get list location";
  }
}