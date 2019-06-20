import 'package:bloc/bloc.dart';

import 'authentication.dart';

import 'package:medical/src/resources/api/api_provider.dart';
import 'package:medical/src/resources/authentication_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  AuthenticationBloc() {
    ApiProvider.setValidateStatus((status) {
      if (status == 401) {
        dispatch(AuthenticationEvent.loggedOut());
      }
      return true;
    });
  }

  @override
  AuthenticationState get initialState => AuthenticationState.unauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event.type == AuthenticationEventType.identified) {
      yield AuthenticationState.authenticating();
      final String _token = await _authenticationRepository.getToken();
      if (_token != null && await _authenticationRepository.isValid()) {
        ApiProvider.setBearerAuth(_token);
        yield AuthenticationState.authenticated(_token);
      } else {
        ApiProvider.setBearerAuth('');
        yield AuthenticationState.unauthenticated();
      }
    }
    if (event.type == AuthenticationEventType.loggedIn) {
      yield AuthenticationState.authenticating();
      await _authenticationRepository.persistToken(event.token);
      ApiProvider.setBearerAuth(event.token);
      yield AuthenticationState.authenticated(event.token);
    }
    if (event.type == AuthenticationEventType.loggedOut) {
      yield AuthenticationState.authenticating();
      try {
        if (await _authenticationRepository.isValid()) {
          await _authenticationRepository.revoke();
        }
      } catch (_) {}
      ApiProvider.setBearerAuth('');
      yield AuthenticationState.unauthenticated();
    }
  }
}
