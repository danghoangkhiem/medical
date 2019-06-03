import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class SynchronizationEvent extends Equatable {
  final SynchronizationEventType type;

  SynchronizationEvent({@required this.type})
      : assert(type != null),
        super([type]);

  factory SynchronizationEvent.sync() =>
      SynchronizationEvent(type: SynchronizationEventType.sync);

  factory SynchronizationEvent.check() =>
      SynchronizationEvent(type: SynchronizationEventType.check);

  factory SynchronizationEvent.hasData() =>
      SynchronizationEvent(type: SynchronizationEventType.hasData);
}

enum SynchronizationEventType { check, sync, hasData }