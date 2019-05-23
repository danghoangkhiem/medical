import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_event.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_state.dart';
import 'package:medical/src/models/report_kpi_day_model.dart';
import 'package:medical/src/resources/report_kpi_date_repository.dart';

import 'package:meta/meta.dart';

class ReportKpiDayBloc extends Bloc<ReportKpiDayEvent, ReportKpiDayState> {

  final ReportKpiDayRepository _reportKpiDayRepository;

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
        ReportKpiDayModel attendance = await _reportKpiDayRepository.getReportKpiDay();
        yield ReportKpiDayLoaded(reportKpiDayModel: attendance);
      } catch (error) {
        yield ReportKpiDayFailure(error: error.toString());
      }
    }
  }

}