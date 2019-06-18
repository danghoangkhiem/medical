import 'package:medical/src/models/report_kpi_month_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ReportKpiMonthState extends Equatable {
  ReportKpiMonthState([List props = const []]) : super(props);
}

class ReportKpiMonthInitial extends ReportKpiMonthState {
  @override
  String toString() => 'ReportKpiMonthInitial';
}

class ReportKpiMonthLoading extends ReportKpiMonthState {
  @override
  String toString() => 'ReportKpiMonthLoading';
}

class ReportKpiMonthLoaded extends ReportKpiMonthState {

  final ReportKpiMonthModel reportKpiMonthModel;
  final int countKpi;

  ReportKpiMonthLoaded({@required this.reportKpiMonthModel, @required this.countKpi}) : super([reportKpiMonthModel, countKpi]);

  @override
  String toString() => 'ReportKpiMonthLoaded';
}

class ReportKpiMonthEmpty extends ReportKpiMonthState {}

class ReportKpiMonthFailure extends ReportKpiMonthState {
  final String error;

  ReportKpiMonthFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ReportKpiMonthFailure { error: $error }';
}





