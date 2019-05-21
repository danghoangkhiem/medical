import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  ChangePasswordState([List props = const []]) : super(props);
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  String toString() => 'ChangePasswordInitial';
}

class ChangePasswordLoading extends ChangePasswordState {
  @override
  String toString() => 'ChangePasswordLoading';
}

class ChangePasswordSuccess extends ChangePasswordState {
  @override
  String toString() => 'ChangePasswordSuccess';
}

class ChangePasswordFailure extends ChangePasswordState {
  final String error;

  ChangePasswordFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ChangePasswordFailure { error: $error }';
}