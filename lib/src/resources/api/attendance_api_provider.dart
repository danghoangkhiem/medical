import 'api_provider.dart';

import '../../models/models.dart';

class AttendanceApiProvider extends ApiProvider {

  Future<AttendancesModel> getAttendance() async {
//    Response _resp = await httpClient.get('/user/category');
//    if (_resp.data['success']) {
//      return AttendancesModel.fromJson(_resp.data['data']);
//    } else {
//      return Future.error(_resp.data['message']);
//    }
    await Future.delayed(Duration(seconds: 1));
    return AttendancesModel.fromJson([
      {
        "id": 1,
        "location": {
          "id": 14,
          "name": "Bệnh viện 115"
        },
        "timeIn": 1558112400000 ,
        "timeOut": 1558112400000
      },
      {
        "id": 2,
        "location": {
          "id": 15,
          "name": "Bệnh viện 116"
        },
        "timeIn": 1558344898188 ,
        "timeOut": 1558344914337
      },
      {
        "id": 3,
        "location": {
          "id": 16,
          "name": "Bệnh viện 117"
        },
        "timeIn": 1558344898188 ,
        "timeOut": 1558344914337
      },
      {
        "id": 3,
        "location": {
          "id": 16,
          "name": "Bệnh viện 117"
        },
        "timeIn": 1558344898188 ,
        "timeOut": 1558344914337
      },
      {
        "id": 3,
        "location": {
          "id": 16,
          "name": "Bệnh viện 117"
        },
        "timeIn": 1558344898188 ,
        "timeOut": 1558344914337
      },
      {
        "id": 3,
        "location": {
          "id": 16,
          "name": "Bệnh viện 117"
        },
        "timeIn": 1558344898188 ,
        "timeOut": 1558344914337
      }
    ]);


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



