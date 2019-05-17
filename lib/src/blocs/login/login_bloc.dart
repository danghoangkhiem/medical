import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';
import 'login.dart';

import 'package:medical/src/resources/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository = UserRepository();
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
        final token = await _userRepository.authenticate(
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
