import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_event.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_state.dart';
import 'package:medical/src/models/report_kpi_day_model.dart';
import 'package:medical/src/resources/report_kpi_date_repository.dart';

import 'package:meta/meta.dart';

class ReportKpiDayBloc extends Bloc<ReportKpiDayEvent, ReportKpiDayState> {

  final ReportKpiDayRepository _reportKpiDayRepository;

  DateTime _currentStartDate;
  DateTime _currentEndDate;
  int _currentOffset;
  int _currentLimit;

  ReportKpiDayBloc({
    @required reportKpiDayRepository,
  }) : _reportKpiDayRepository = reportKpiDayRepository;

  @override
  ReportKpiDayState get initialState => ReportKpiDayInitial();

  @override
  Stream<ReportKpiDayState> mapEventToState(ReportKpiDayEvent event) async* {
    if (event is GetReportKpiDay) {

      yield ReportKpiDayLoading();
      try {
        if(event.starDay ==null || event.endDay ==null){
          throw 'Phải chọn thời gian';
        }
        else{
          ReportKpiDayModel listKpiDay = await _reportKpiDayRepository.getReportKpiDay(
              startDate: _currentStartDate = event.starDay,
              endDate: _currentEndDate = event.endDay,
              offset: _currentOffset = event.offset,
              limit:  _currentLimit = event.limit
          );

          yield ReportKpiDayLoaded(reportKpiDayModel: listKpiDay);
        }
        //int count = 0;

//        listKpiDay.listKpiDayItem.forEach((item){
//          count+=item.countVisit;
//        });
      } catch (error) {
        yield ReportKpiDayFailure(error: error.toString());
      }
    }
    if(event is GetReportKpiDayMore){
      yield ReportKpiDayLoading(isLoadMore: true);
      try {
        final listKpiDay = await _reportKpiDayRepository.getReportKpiDay(
            startDate: _currentStartDate,
            endDate: _currentEndDate,
            offset: _currentOffset = _currentOffset + _currentLimit,
            limit:  _currentLimit
        );
        if (listKpiDay.listKpiDayItem.length == 0) {
          yield ReachMax();
        } else {
          yield ReportKpiDayLoaded(reportKpiDayModel: listKpiDay, isLoadMore: true);
        }
      } catch (error) {
        yield ReportKpiDayFailure(error: error.toString());
      }

    }
  }

}