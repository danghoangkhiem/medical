import 'package:medical/src/models/report_kpi_month_model.dart';
import 'api_provider.dart';

class ReportKpiMonthApiProvider extends ApiProvider {

  Future<ReportKpiMonthModel> getReportKpiMonth() async {
    await Future.delayed(Duration(seconds: 2));
    return ReportKpiMonthModel.fromJson([
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      },
      {
        "name": "Hoàng Thiên Mệnh" ,
        "type": "B",
        "count": 4
      }
    ]);
  }
}



