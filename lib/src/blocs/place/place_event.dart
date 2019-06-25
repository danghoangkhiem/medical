import 'package:meta/meta.dart';

@immutable
abstract class PlaceEvent {}

class FetchData extends PlaceEvent {}