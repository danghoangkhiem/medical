import 'package:medical/src/models/report_kpi_date_model.dart';
import 'package:medical/src/resources/api/api_response_error.dart';
import 'api_provider.dart';

class ReportKpiDayApiProvider extends ApiProvider {

  Future<ReportKpiDateModel> getReportKpiDate({DateTime startDate, DateTime endDate}) async {
    //await Future.delayed(Duration(milliseconds: 500));

    Map<String, dynamic> _queryParameters = {
      'startDate':
      DateTime(startDate.year, startDate.month, startDate.day, 00, 00, 00)
          .millisecondsSinceEpoch ~/
          1000,
      'endDate':
      DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59)
          .millisecondsSinceEpoch ~/
          1000,
    };

    Response _resp = await httpClient.get('/reports/kpi/date',
        queryParameters: _queryParameters);

    if (_resp.statusCode == 200) {

      return ReportKpiDateModel.fromJson(_resp.data["date"]);

    }
    return Future.error(ApiResponseError.fromJson(_resp.data));



  }
}



