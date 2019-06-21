import 'package:meta/meta.dart';

import 'package:medical/src/models/partner_model.dart';

@immutable
abstract class PartnerState {}

class Initial extends PartnerState {}

class Loading extends PartnerState {}

class Success extends PartnerState {
  final PartnerListModel partners;

  Success({@required this.partners});
}

class Failure extends PartnerState {
  final String error;

  Failure({@required this.error});
}
