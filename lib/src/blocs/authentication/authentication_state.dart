import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AuthenticationState extends Equatable {
  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool hasFailed;

  final String token;
  final String error;

  AuthenticationState(
      {@required this.isAuthenticated,
        this.isAuthenticating: false,
        this.hasFailed: false,
        this.token: '',
        this.error: ''})
      : super([
    isAuthenticated,
    isAuthenticating,
    hasFailed,
    token,
    error
  ]);

  factory AuthenticationState.unauthenticated() => AuthenticationState(
    isAuthenticated: false,
  );

  factory AuthenticationState.authenticating() => AuthenticationState(
    isAuthenticated: false,
    isAuthenticating: true,
  );

  factory AuthenticationState.authenticated(String token) =>
      AuthenticationState(
          isAuthenticated: true,
          token: token);

  factory AuthenticationState.failure(String errorMessage) =>
      AuthenticationState(
          isAuthenticated: false, hasFailed: true, error: errorMessage);
}
