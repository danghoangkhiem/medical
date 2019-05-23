class AdditionalType {
  static final AdditionalType samples = AdditionalType._('samples');
  static final AdditionalType gifts = AdditionalType._('gifts');
  static final AdditionalType purchases = AdditionalType._('purchases');
  static final AdditionalType pointOfSaleMaterials = AdditionalType._('posm');

  final String value;

  const AdditionalType._(this.value);

  @override
  String toString() => value;
}