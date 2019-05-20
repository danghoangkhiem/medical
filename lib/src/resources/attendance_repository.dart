import 'package:medical/src/resources/api/attendance_api_provider.dart';
import 'package:meta/meta.dart';
import '../models/models.dart';

class UserRepository {
  final AttendanceApiProvider _attendanceApiProvider = AttendanceApiProvider();

  Future<AttendancesModel> getAttendance() async {
    return await _attendanceApiProvider.getAttendance();
  }
}
