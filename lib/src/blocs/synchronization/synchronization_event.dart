import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class SynchronizationEvent extends Equatable {
  final SynchronizationEventType type;
  final int userId;

  SynchronizationEvent({@required this.type, this.userId})
      : assert(type != null),
        super([type, userId]);

  factory SynchronizationEvent.sync() =>
      SynchronizationEvent(type: SynchronizationEventType.sync);

  factory SynchronizationEvent.check({@required int userId}) =>
      SynchronizationEvent(
          type: SynchronizationEventType.check, userId: userId);

  factory SynchronizationEvent.hasData() =>
      SynchronizationEvent(type: SynchronizationEventType.hasData);
}

enum SynchronizationEventType { check, sync, hasData }
