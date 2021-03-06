import 'package:medical/src/models/report_kpi_date_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ReportKpiDayState extends Equatable {
  ReportKpiDayState([List props = const []]) : super(props);
}

class ReportKpiDayInitial extends ReportKpiDayState {
  @override
  String toString() => 'ReportKpiDayInitial';
}

class ReportKpiDateLoading extends ReportKpiDayState {
  @override
  String toString() => 'ReportKpiDayLoading';
}

class ReportKpiDateLoaded extends ReportKpiDayState {

  final ReportKpiDateModel reportKpiDateModel;
  final int countKpi;

  ReportKpiDateLoaded({@required this.reportKpiDateModel, @required this.countKpi}) : super([reportKpiDateModel, countKpi]);

  @override
  String toString() => 'ReportKpiDateLoaded';
}

class ReportKpiEmpty extends ReportKpiDayState {}

class ReportKpiDateFailure extends ReportKpiDayState {
  final String error;

  ReportKpiDateFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ReportKpiDateFailure { error: $error }';
}





