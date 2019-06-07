import 'package:medical/src/models/manage_area_model.dart';
import 'package:meta/meta.dart';
import 'api_provider.dart';

class ManageAreaApiProvider extends ApiProvider {

  Future<ManageAreaModel> getManageArea({int offset = 0, int limit = 10, @required DateTime date}) async {
    await Future.delayed(Duration(seconds: 1));
    return ManageAreaModel.fromJson([
      {
        "id": 2,
        "startTime": 1559927049446,
        "endTime": 1559927049746,
        "realStartTime": null,
        "realEndTime": null,
        "doctorName": "Nhật Thuần Phong 2",
        "addressType": "benh vien",
        "addressName": "binh thah",
        "status": 1,
        "targetBefore": "",
        "targetAfter": ""
      },
      {
        "id": 3,
        "startTime": 1559927049446,
        "endTime": 1559927049746,
        "realStartTime": null,
        "realEndTime": null,
        "doctorName": "Nhật Thuần Phong 3",
        "addressType": "benh vien",
        "addressName": "binh thah",
        "status": 1,
        "targetBefore": "",
        "targetAfter": ""
      }
    ]);

//    Map<String, dynamic> _queryParameters = {
//      'offset': offset,
//      'limit': limit,
//      'date':
//      DateTime(date.year, date.month, date.day, 00, 00, 00)
//          .millisecondsSinceEpoch ~/
//          1000
//    };
//
//    Response _resp = await httpClient.get('/attendances/attendances',
//        queryParameters: _queryParameters);
//
//    if (_resp.statusCode == 200) {
//      return ManageAreaModel.fromJson(_resp.data["data"]);
//    }
//    return Future.error(ApiResponseError.fromJson(_resp.data));

  }

}



