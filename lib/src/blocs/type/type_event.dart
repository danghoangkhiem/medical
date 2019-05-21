import 'package:equatable/equatable.dart';

abstract class TypeEvent extends Equatable {
  TypeEvent([List props = const []]) : super(props);
}

class GetType extends TypeEvent {}
