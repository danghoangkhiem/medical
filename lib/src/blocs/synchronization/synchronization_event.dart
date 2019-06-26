import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class SynchronizationEvent extends Equatable {
  final SynchronizationEventType type;
  final int userId;

  SynchronizationEvent({@required this.type, this.userId})
      : assert(type != null),
        super([type, userId]);

  factory SynchronizationEvent.synchronize({@required int userId}) =>
      SynchronizationEvent(type: SynchronizationEventType.sync, userId: userId);

  factory SynchronizationEvent.check({@required int userId}) =>
      SynchronizationEvent(
          type: SynchronizationEventType.check, userId: userId);

  factory SynchronizationEvent.compact() =>
      SynchronizationEvent(type: SynchronizationEventType.compact);

  factory SynchronizationEvent.hasData() =>
      SynchronizationEvent(type: SynchronizationEventType.hasData);
}

enum SynchronizationEventType { check, sync, compact, hasData }
