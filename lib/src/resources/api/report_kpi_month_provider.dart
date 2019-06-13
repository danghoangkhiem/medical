import 'package:medical/src/models/report_kpi_month_model.dart';
import 'package:medical/src/resources/api/api_response_error.dart';
import 'api_provider.dart';

class ReportKpiMonthApiProvider extends ApiProvider {

  Future<ReportKpiMonthModel> getReportKpiMonth( {DateTime startMonth} ) async {
    //await Future.delayed(Duration(seconds: 2));
    Map<String, dynamic> _queryParameters = {
      'date':
      DateTime(startMonth.year, startMonth.month, startMonth.day, 00, 00, 00)
          .millisecondsSinceEpoch ~/
          1000
    };

    Response _resp = await httpClient.get('/reports/kpi/month',
        queryParameters: _queryParameters);

    if (_resp.statusCode == 200) {

      return ReportKpiMonthModel.fromJson(_resp.data["data"]);
    }

    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}



