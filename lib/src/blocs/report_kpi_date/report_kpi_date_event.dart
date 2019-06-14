import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ReportKpiDayEvent extends Equatable {
  ReportKpiDayEvent([List props = const []]) : super(props);
}

class GetReportKpiDay extends ReportKpiDayEvent {
  final DateTime starDay;
  final DateTime endDay;


  GetReportKpiDay({
    @required this.starDay,
    @required this.endDay,

  }) : super([starDay, endDay]);

  @override
  String toString() {
    return "Get list report kpi date by day";
  }
}

class GetReportKpiDayMore extends ReportKpiDayEvent{}

