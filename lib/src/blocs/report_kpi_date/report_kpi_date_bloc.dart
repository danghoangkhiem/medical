import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_event.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_state.dart';
import 'package:medical/src/models/report_kpi_day_model.dart';
import 'package:medical/src/resources/report_kpi_date_repository.dart';

import 'package:meta/meta.dart';

class ReportKpiDateBloc extends Bloc<ReportKpiDayEvent, ReportKpiDayState> {

  final ReportKpiDateRepository _reportKpiDateRepository;

  int count;

  ReportKpiDateBloc({
    @required reportKpiDateRepository,
  }) : _reportKpiDateRepository = reportKpiDateRepository;

  @override
  ReportKpiDayState get initialState => ReportKpiDayInitial();

  @override
  Stream<ReportKpiDayState> mapEventToState(ReportKpiDayEvent event) async* {
    if (event is GetReportKpiDay) {

      yield ReportKpiDateLoading();
      try {
        if(event.starDay ==null || event.endDay ==null){
          throw 'Phải chọn thời gian';
        }
        else{
          ReportKpiDateModel listKpiDay = await _reportKpiDateRepository.getReportKpiDay(
              startDate:  event.starDay,
              endDate:  event.endDay,
              offset:  event.offset,
              limit:   event.limit
          );

          //viet ham lấy tổng lượt viếng thăm
          count = 26;
          yield ReportKpiDateLoaded(reportKpiDateModel: listKpiDay, countKpi: count);
        }

      } catch (error) {
        yield ReportKpiDateFailure(error: error.toString());
      }
    }

  }

}