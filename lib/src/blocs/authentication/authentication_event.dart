import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class AuthenticationEvent extends Equatable {
  final AuthenticationEventType type;
  final String token;

  AuthenticationEvent(
      {this.type: AuthenticationEventType.identified, this.token: ''})
      : assert(type != null),
        super([type, token]);

  factory AuthenticationEvent.identified() => AuthenticationEvent();

  factory AuthenticationEvent.loggedIn({@required String token}) =>
      AuthenticationEvent(
          type: AuthenticationEventType.loggedIn, token: token);

  factory AuthenticationEvent.loggedOut() => AuthenticationEvent(
    type: AuthenticationEventType.loggedOut,
  );
}

enum AuthenticationEventType { identified, loggedIn, loggedOut }
