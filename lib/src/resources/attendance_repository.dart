import 'package:medical/src/resources/api/attendance_api_provider.dart';
import 'package:meta/meta.dart';
import '../models/models.dart';

class AttendanceRepository {


  final AttendanceApiProvider _attendanceApiProvider = AttendanceApiProvider();

  Future<AttendancesModel> getAttendance() async {
    return await _attendanceApiProvider.getAttendance();
  }







//  Future<CatalogModel> getCatalog() async {
//    return await _userApiProvider.getCatalog();
//  }

//  Future<String> getAccessToken() async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    final String accessToken = prefs.getString(_accessTokenKeyName);
//    return accessToken;
//  }


}