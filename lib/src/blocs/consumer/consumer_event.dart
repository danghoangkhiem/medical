import 'package:meta/meta.dart';

import 'package:medical/src/models/consumer_model.dart';

@immutable
abstract class ConsumerEvent {}

class AdditionalFields extends ConsumerEvent {}

class SearchPhoneNumber extends ConsumerEvent {
  final String phoneNumber;

  SearchPhoneNumber({@required this.phoneNumber});
}

class NextStep extends ConsumerEvent {
  final ConsumerModel consumer;

  NextStep({@required this.consumer});
}

class PrevStep extends ConsumerEvent {}