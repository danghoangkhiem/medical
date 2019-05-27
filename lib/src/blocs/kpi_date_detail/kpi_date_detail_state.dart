import 'package:medical/src/models/kpi_date_detail_model.dart';
import 'package:medical/src/models/report_kpi_day_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ReportKpiDayDetailState extends Equatable {
  ReportKpiDayDetailState([List props = const []]) : super(props);
}

class ReportKpiDayDetailInitial extends ReportKpiDayDetailState {
  @override
  String toString() => 'ReportKpiDayDetailInitial';
}

class ReportKpiDayDetailLoading extends ReportKpiDayDetailState {

  @override
  String toString() => 'ReportKpiDayDetailLoading';
}

class ReportKpiDayDetailLoaded extends ReportKpiDayDetailState {

  final ReportKpiDayDetailModel reportKpiDayDetailModel;


  ReportKpiDayDetailLoaded({@required this.reportKpiDayDetailModel}) : super([reportKpiDayDetailModel]);

  @override
  String toString() => 'ReportKpiDayDetailLoaded';
}


class ReportKpiDayDetailFailure extends ReportKpiDayDetailState {
  final String error;

  ReportKpiDayDetailFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ReportKpiDayDetailFailure { error: $error }';
}





