import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ReportKpiMonthEvent extends Equatable {
  ReportKpiMonthEvent([List props = const []]) : super(props);
}

class GetReportKpiMonth extends ReportKpiMonthEvent {
  final DateTime starDay;
  final DateTime endDay;
  final int offset;
  final int limit;

  GetReportKpiMonth({
    @required this.starDay,
    @required this.endDay,
    @required this.offset,
    this.limit = 10,
  }) : super([starDay, endDay, offset, limit]);

  @override
  String toString() {
    return "Get list report kpi month by month";
  }
}

class GetReportKpiMonthMore extends ReportKpiMonthEvent{}

