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

  final bool isLoadMore;

  ReportKpiDayLoading({this.isLoadMore = false});

  @override
  String toString() => 'ReportKpiDayLoading';
}

class ReportKpiDayLoaded extends ReportKpiDayState {
  final bool isLoadMore;
  final ReportKpiDayModel reportKpiDayModel;
  final int countKpi;
  //ReportKpiDayLoaded({@required this.reportKpiDayModel, @required this.countKpi}) : super([reportKpiDayModel, countKpi]);

  ReportKpiDayLoaded({@required this.reportKpiDayModel,this.isLoadMore = false, @required this.countKpi}) : super([reportKpiDayModel, isLoadMore, countKpi]);

  @override
  String toString() => 'ReportKpiDayLoaded';
}

class ReachMax extends ReportKpiDayState {}

class ReportKpiDayFailure extends ReportKpiDayState {
  final String error;

  ReportKpiDayFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ReportKpiDayFailure { error: $error }';
}





