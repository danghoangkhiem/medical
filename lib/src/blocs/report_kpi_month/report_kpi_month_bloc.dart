import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/report_kpi_month/report_kpi_month_event.dart';
import 'package:medical/src/blocs/report_kpi_month/report_kpi_month_state.dart';
import 'package:medical/src/models/report_kpi_month_model.dart';
import 'package:medical/src/resources/report_kpi_month_repository.dart';

import 'package:meta/meta.dart';

class ReportKpiMonthBloc extends Bloc<ReportKpiMonthEvent, ReportKpiMonthState> {

  final ReportKpiMonthRepository _reportKpiMonthRepository;

  int count;

  ReportKpiMonthBloc({
    @required reportKpiMonthRepository,
  }) : _reportKpiMonthRepository = reportKpiMonthRepository;

  @override
  ReportKpiMonthState get initialState => ReportKpiMonthInitial();

  @override
  Stream<ReportKpiMonthState> mapEventToState(ReportKpiMonthEvent event) async* {
    if (event is GetReportKpiMonth) {

      yield ReportKpiMonthLoading();
      try {
        if(event.starMonth == null){
          throw 'Phải chọn thời gian';
        }
        else{
          ReportKpiMonthModel listKpiMonth = await _reportKpiMonthRepository.getReportKpiMonth(
              startMonth: event.starMonth,
              offset: event.offset,
              limit: event.limit
          );

          //viet ham lấy tổng lượt viếng thăm
          count = 26;
          yield ReportKpiMonthLoaded(reportKpiMonthModel: listKpiMonth, countKpi: count);
        }

      } catch (error) {
        yield ReportKpiMonthFailure(error: error.toString());
      }
    }

  }

}