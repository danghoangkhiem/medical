import 'package:equatable/equatable.dart';

class ApplicationEvent extends Equatable {
  final ApplicationEventType type;

  ApplicationEvent({this.type})
      : assert(type != null),
        super([type]);

  factory ApplicationEvent.launched() =>
      ApplicationEvent(type: ApplicationEventType.launched);

  factory ApplicationEvent.initialized() =>
      ApplicationEvent(type: ApplicationEventType.initialized);
}

enum ApplicationEventType { launched, initialized }
