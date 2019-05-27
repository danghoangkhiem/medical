import 'package:equatable/equatable.dart';

abstract class ReportKpiDayDetailEvent extends Equatable {
  ReportKpiDayDetailEvent([List props = const []]) : super(props);
}

class GetReportKpiDayDetail extends ReportKpiDayDetailEvent {
  final DateTime byDate;
  GetReportKpiDayDetail({this.byDate}) : super([byDate]);

  @override
  String toString() {
    return "Get list  ReportKpiDayDetail";
  }

}



