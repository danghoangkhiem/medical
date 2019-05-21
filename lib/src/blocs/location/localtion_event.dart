import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LocationEvent extends Equatable {
  LocationEvent([List props = const []]) : super(props);
}
//
class GetLocation extends LocationEvent {

  GetLocation() : super();

  @override
  String toString() {
    return "Get list location";
  }
}