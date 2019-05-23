import 'package:medical/src/models/report_kpi_day_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ReportKpiDayState extends Equatable {
  ReportKpiDayState([List props = const []]) : super(props);
}

class ReportKpiDayInitial extends ReportKpiDayState {
  @override
  String toString() => 'ReportKpiDayInitial';
}

class ReportKpiDayLoading extends ReportKpiDayState {
  @override
  String toString() => 'ReportKpiDayLoading';
}

class ReportKpiDayLoaded extends ReportKpiDayState {
  final ReportKpiDayModel reportKpiDayModel;

  ReportKpiDayLoaded({@required this.reportKpiDayModel}) : super([reportKpiDayModel]);

  @override
  String toString() => 'ReportKpiDayLoaded';
}

class ReportKpiDayFailure extends ReportKpiDayState {
  final String error;

  ReportKpiDayFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ReportKpiDayFailure { error: $error }';
}





