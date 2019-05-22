import 'package:medical/src/models/attendances_model.dart';
import 'package:medical/src/models/type_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class TypeState extends Equatable {
  TypeState([List props = const []]) : super(props);
}

class TypeInitial extends TypeState {
  @override
  String toString() => 'TypeInitial';
}

class TypeLoading extends TypeState {
  @override
  String toString() => 'TypeLoading';
}

class TypeLoaded extends TypeState {
  final TypeModel type;

  TypeLoaded({@required this.type}) : super([type]);

  @override
  String toString() => 'TypeLoaded';
}

class TypeFailure extends TypeState {
  final String error;

  TypeFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'TypeFailure { error: $error }';
}