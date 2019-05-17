import 'package:bloc/bloc.dart';

import 'authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  @override
  AuthenticationState get initialState => AuthenticationState.unauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event.type == AuthenticationEventType.identified) {
      yield AuthenticationState.authenticating();
      yield AuthenticationState.authenticated('');
      //yield AuthenticationState.unauthenticated();
      //yield AuthenticationState.failure('Phiên làm việc của bạn đã hết hạn');
    }
    if (event.type == AuthenticationEventType.loggedIn) {
      yield AuthenticationState.authenticating();
      yield AuthenticationState.authenticated(event.token);
    }
    if (event.type == AuthenticationEventType.loggedOut) {
      yield AuthenticationState.authenticating();
      yield AuthenticationState.unauthenticated();
    }
  }
}
