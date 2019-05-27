import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ReportKpiDayEvent extends Equatable {
  ReportKpiDayEvent([List props = const []]) : super(props);
}

class GetReportKpiDay extends ReportKpiDayEvent {
  final DateTime starDay;
  final DateTime endDay;
  final int offset;
  final int limit;

  GetReportKpiDay({
    @required this.starDay,
    @required this.endDay,
    @required this.offset,
    this.limit = 10,
  }) : super([starDay, endDay, offset, limit]);

  @override
  String toString() {
    return "Get list report kpi date by day";
  }
}

class GetReportKpiDayMore extends ReportKpiDayEvent{}

