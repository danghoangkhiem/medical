abstract class ApplicationEvent {}

class AppLaunched extends ApplicationEvent {
  @override
  String toString() {
    return 'AppLaunched';
  }
}