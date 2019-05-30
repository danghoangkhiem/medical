class EventType {
  static final EventType samples = EventType._('samples');
  static final EventType gifts = EventType._('gifts');
  static final EventType purchases = EventType._('purchases');
  static final EventType pointOfSaleMaterials = EventType._('posm');

  final String value;

  const EventType._(this.value);

  @override
  String toString() => value;
}