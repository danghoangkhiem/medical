import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';
import 'login.dart';

import 'package:medical/src/resources/authentication_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final AuthenticationBloc _authenticationBloc;

  LoginBloc({@required authenticationBloc})
      : assert(authenticationBloc != null),
        _authenticationBloc = authenticationBloc;

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        if (event.username.isEmpty || event.password.isEmpty) {
          throw 'Tên đăng nhập hoặc mật khẩu không được bỏ trống';
        }
        final token = await _authenticationRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        _authenticationBloc
            .dispatch(AuthenticationEvent.loggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
