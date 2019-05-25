import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ReportKpiMonthEvent extends Equatable {
  ReportKpiMonthEvent([List props = const []]) : super(props);
}

class GetReportKpiMonth extends ReportKpiMonthEvent {
  final DateTime starMonth;
  final int offset;
  final int limit;

  GetReportKpiMonth({
    @required this.starMonth,
    @required this.offset,
    this.limit = 10,
  }) : super([starMonth, offset, limit]);

  @override
  String toString() {
    return "Get list report kpi month by month";
  }
}

class GetReportKpiMonthMore extends ReportKpiMonthEvent{}

