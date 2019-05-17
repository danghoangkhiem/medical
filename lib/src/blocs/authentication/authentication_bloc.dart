import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  @override
  AuthenticationState get initialState => AuthenticationState.unauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {

  }
}
