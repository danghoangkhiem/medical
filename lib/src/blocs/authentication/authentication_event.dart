abstract class AuthenticationEvent {}

class Unauthenticated extends AuthenticationEvent {
  @override
  String toString() {
    return 'Unauthenticated';
  }
}