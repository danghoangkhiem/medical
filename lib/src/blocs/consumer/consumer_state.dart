import 'package:meta/meta.dart';

import 'package:medical/src/models/additional_field_model.dart';
import 'package:medical/src/models/additional_data_model.dart';
import 'package:medical/src/models/consumer_model.dart';

ConsumerModel defaultConsumerInformation() => ConsumerModel(
  phoneNumber: null,
  additionalData: AdditionalDataModel(
    samples: AdditionalFieldListModel.fromJson([]),
    gifts: AdditionalFieldListModel.fromJson([]),
    purchases: AdditionalFieldListModel.fromJson([]),
    pointOfSaleMaterials: AdditionalFieldListModel.fromJson([]),
  ),
);

abstract class ConsumerState {
  final int currentStep = 0;
  final ConsumerModel consumer = defaultConsumerInformation();
}

class Initial extends ConsumerState {}

class Loading extends ConsumerState {}

class Loaded extends ConsumerState {
  final AdditionalDataModel additionalFields;

  Loaded({@required this.additionalFields});
}

class Failure extends ConsumerState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}

class FatalError extends ConsumerState {
  final String errorMessage;

  FatalError({@required this.errorMessage});
}

class Searching extends ConsumerState {}

class FinishedSearching extends ConsumerState {}

class Stepped extends ConsumerState {
  final int currentStep;
  final String error;
  final ConsumerModel consumer;

  Stepped(this.currentStep, {@required this.consumer, this.error});
}

class Added extends ConsumerState {}
