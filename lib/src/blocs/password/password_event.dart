import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  ChangePasswordEvent([List props = const []]) : super(props);
}

class ChangePasswordButtonPressed extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordButtonPressed({
    @required this.oldPassword,
    @required this.newPassword,
    @required this.confirmPassword,
  }) : super([oldPassword, oldPassword, confirmPassword]);

  @override
  String toString() =>
      'ChangePasswordButtonPressed { old-password: $oldPassword, new-password: $oldPassword }';
}