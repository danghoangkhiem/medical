import 'api_provider.dart';

import '../../models/models.dart';

class AttendanceApiProvider extends ApiProvider {

  Future<AttendancesModel> getAttendance() async {
    Response _resp = await httpClient.get('/user/category');
    if (_resp.data['success']) {
      return AttendancesModel.fromJson(_resp.data['data']);
    } else {
      return Future.error(_resp.data['message']);
    }
  }

}

