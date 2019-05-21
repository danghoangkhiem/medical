import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';
import 'password.dart';

import 'package:medical/src/resources/user_repository.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository _userRepository = UserRepository();
  final AuthenticationBloc _authenticationBloc;

  ChangePasswordBloc({@required authenticationBloc})
      : assert(authenticationBloc != null),
        _authenticationBloc = authenticationBloc;

  ChangePasswordState get initialState => ChangePasswordInitial();

  @override
  Stream<ChangePasswordState> mapEventToState(ChangePasswordEvent event) async* {
    if (event is ChangePasswordButtonPressed) {
      yield ChangePasswordLoading();
      try {
        if (event.oldPassword.isEmpty ||
            event.newPassword.isEmpty ||
            event.confirmPassword.isEmpty) {
          throw 'Hãy nhập đầy đủ thông tin vào các trường phía trên';
        }
        if (event.confirmPassword != event.newPassword) {
          throw 'Mật khẩu xác nhận không đúng với mật khẩu mới';
        }
        await _userRepository.changePassword(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        );
        _authenticationBloc
            .dispatch(AuthenticationEvent.loggedOut());
        yield ChangePasswordSuccess();
      } catch (error) {
        yield ChangePasswordFailure(error: error.toString());
      }
    }
  }
}
