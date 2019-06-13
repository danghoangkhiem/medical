import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ReportKpiMonthEvent extends Equatable {
  ReportKpiMonthEvent([List props = const []]) : super(props);
}

class GetReportKpiMonth extends ReportKpiMonthEvent {
  final DateTime startMonth;

  GetReportKpiMonth({
    @required this.startMonth,
  }) : super([startMonth]);

  @override
  String toString() {
    return "Get list report kpi month by month";
  }
}

class GetReportKpiMonthMore extends ReportKpiMonthEvent{}

