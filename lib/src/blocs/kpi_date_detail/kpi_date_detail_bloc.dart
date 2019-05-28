import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/kpi_date_detail/kpi_date_detail_event.dart';
import 'package:medical/src/blocs/kpi_date_detail/kpi_date_detail_state.dart';
import 'package:medical/src/models/kpi_date_detail_model.dart';
import 'package:medical/src/resources/kpi_date_detail_repository.dart';


import 'package:meta/meta.dart';

class KpiDateDetailBloc extends Bloc<ReportKpiDayDetailEvent, ReportKpiDayDetailState> {

  final KpiDateDetailRepository _kpiDateDetailRepository;

  KpiDateDetailBloc({
    @required kpiDateDetailRepository,
  }) : _kpiDateDetailRepository = kpiDateDetailRepository;

  @override
  ReportKpiDayDetailState get initialState => ReportKpiDayDetailInitial();

  @override
  Stream<ReportKpiDayDetailState> mapEventToState(ReportKpiDayDetailEvent event) async* {
    if (event is GetReportKpiDayDetail) {
      yield ReportKpiDayDetailLoading();
      try {
        ReportKpiDayDetailModel kpiDateDetail = await _kpiDateDetailRepository.getKpiDateDetail(byDate: event.byDate);

        yield ReportKpiDayDetailLoaded(reportKpiDayDetailModel: kpiDateDetail);
      } catch (error) {
        yield ReportKpiDayDetailFailure(error: error.toString());
      }
    }


  }

}


