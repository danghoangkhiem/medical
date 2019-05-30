import 'package:meta/meta.dart';

import 'package:medical/src/models/additional_data_model.dart';

@immutable
abstract class ConsumerState {
  final int currentStep = 0;
}

class Initial extends ConsumerState {}

class Loading extends ConsumerState {}

class Loaded extends ConsumerState {
  final AdditionalDataModel additionalFields;

  Loaded({this.additionalFields});
}

class Failure extends ConsumerState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}

class Searching extends ConsumerState {}

class FinishedSearching extends ConsumerState {}

class Stepped extends ConsumerState {
  final int currentStep;

  Stepped(this.currentStep);
}