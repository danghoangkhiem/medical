import 'package:medical/src/resources/api/attendance_api_provider.dart';
import '../models/models.dart';

class AttendanceRepository {

  final AttendanceApiProvider _attendanceApiProvider = AttendanceApiProvider();

  Future<AttendancesModel> getAttendance({DateTime startDate, DateTime endDate ,int offset, int limit}) async {
    return await _attendanceApiProvider.getAttendance(offset: offset, limit: limit, startDate: startDate, endDate: endDate);
  }

}