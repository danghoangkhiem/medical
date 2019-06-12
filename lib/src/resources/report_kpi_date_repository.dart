import 'package:medical/src/models/report_kpi_day_model.dart';
import 'package:medical/src/resources/api/report_kpi_date_provider.dart';

class ReportKpiDateRepository {

  final ReportKpiDayApiProvider _reportKpiDayApiProvider = ReportKpiDayApiProvider();

  Future<ReportKpiDateModel> getReportKpiDay({DateTime startDate, DateTime endDate, int offset, int limit}) async {
    return await _reportKpiDayApiProvider.getReportKpiDay();
  }

}