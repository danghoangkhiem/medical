import 'package:medical/src/models/kpi_date_detail_model.dart';
import 'package:medical/src/resources/api/kpi_date_detail_provider.dart';

class KpiDateDetailRepository {

  final KpiDateDetailProvider _kpiDateDetailProvider = KpiDateDetailProvider();

  Future<ReportKpiDayDetailModel> getKpiDateDetail({DateTime byDate}) async {
    return await _kpiDateDetailProvider.getKpiDateDetail(byDate: byDate);
  }

}