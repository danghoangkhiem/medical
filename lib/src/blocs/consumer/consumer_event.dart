import 'package:meta/meta.dart';

@immutable
abstract class ConsumerEvent {}

class GetAdditionalFields extends ConsumerEvent {}

class SearchPhoneNumber extends ConsumerEvent {
  final String phoneNumber;

  SearchPhoneNumber({@required this.phoneNumber});
}

class NextStepButtonPressed extends ConsumerEvent {}