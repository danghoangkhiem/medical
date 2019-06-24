import 'package:meta/meta.dart';

@immutable
abstract class PartnerEvent {}

class FetchData extends PartnerEvent {
  final int placeId;

  FetchData({@required this.placeId});
}