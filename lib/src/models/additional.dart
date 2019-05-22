class Additional {
  static final Additional samples = Additional._('samples');
  static final Additional gifts = Additional._('gifts');
  static final Additional purchases = Additional._('purchases');
  static final Additional pointOfSaleMaterials = Additional._('posm');

  final String value;

  const Additional._(this.value);

  @override
  String toString() => value;
}