import 'package:medical/src/resources/api/api_response_error.dart';
import 'package:meta/meta.dart';

import 'api_provider.dart';

import '../../models/models.dart';

class AttendanceApiProvider extends ApiProvider {

  Future<AttendancesModel> getAttendance({int offset = 0, int limit = 10, @required DateTime startDate,@required DateTime endDate}) async {

    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
      'startDate':
      DateTime(startDate.year, startDate.month, startDate.day, 00, 00, 00)
          .millisecondsSinceEpoch ~/
          1000,
      'endDate':
      DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59)
          .millisecondsSinceEpoch ~/
          1000,
    };

    Response _resp = await httpClient.get('/attendances/attendances',
        queryParameters: _queryParameters);

    if (_resp.statusCode == 200) {
      return AttendancesModel.fromJson(_resp.data["data"]);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data['error']));

  }


  Future<AttendancesModel> getAttendanceMore() async {
    await Future.delayed(Duration(seconds: 1));
    return AttendancesModel.fromJson([
      {
        "id": 8,
        "location": {
          "id": 14,
          "name": "Bệnh viện A"
        },
        "timeIn": 1558112400000 ,
        "timeOut": 1558112400000
      },
      {
        "id": 9,
        "location": {
          "id": 15,
          "name": "Bệnh viện B"
        },
        "timeIn": 1558344898188 ,
        "timeOut": 1558344914337
      },
      {
        "id": 10,
        "location": {
          "id": 16,
          "name": "Bệnh viện C"
        },
        "timeIn": 1558344898188 ,
        "timeOut": 1558344914337
      }
    ]);


  }

}



