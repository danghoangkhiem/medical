import 'package:medical/src/models/report_kpi_day_model.dart';
import 'api_provider.dart';

class ReportKpiDayApiProvider extends ApiProvider {

  Future<ReportKpiDayModel> getReportKpiDay() async {
    await Future.delayed(Duration(seconds: 1));
    return ReportKpiDayModel.fromJson([
      {
        "date": 1558112400000 ,
        "countVisit": 4
      },
      {
        "date": 1558112400000 ,
        "countVisit": 5
      },
      {
        "date": 1558112400000 ,
        "countVisit": 2
      }
    ]);
  }
}



