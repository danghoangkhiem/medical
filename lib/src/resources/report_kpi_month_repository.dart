import 'package:medical/src/models/report_kpi_month_model.dart';
import 'package:medical/src/resources/api/report_kpi_month_provider.dart';

class ReportKpiMonthRepository {

  final ReportKpiMonthApiProvider _reportKpiMonthApiProvider = ReportKpiMonthApiProvider();

  Future<ReportKpiMonthModel> getReportKpiMonth({DateTime startDate, DateTime endDate, int offset, int limit}) async {
    return await _reportKpiMonthApiProvider.getReportKpiMonth();
  }

}