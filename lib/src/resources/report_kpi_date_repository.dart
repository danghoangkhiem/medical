import 'package:medical/src/models/report_kpi_day_model.dart';
import 'package:medical/src/resources/api/report_kpi_date_provider.dart';

class ReportKpiDayRepository {

  final ReportKpiDayApiProvider _reportKpiDayApiProvider = ReportKpiDayApiProvider();

  Future<ReportKpiDayModel> getReportKpiDay() async {
    return await _reportKpiDayApiProvider.getReportKpiDay();
  }

}