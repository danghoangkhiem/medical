import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  ChangePasswordEvent([List props = const []]) : super(props);
}

class ChangePasswordButtonPressed extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordButtonPressed({
    @required this.oldPassword,
    @required this.newPassword,
  }) : super([oldPassword, oldPassword]);

  @override
  String toString() =>
      'ChangePasswordButtonPressed { old-password: $oldPassword, new-password: $oldPassword }';
}
