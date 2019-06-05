import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/user_api_provider.dart';

import 'package:medical/src/models/user_model.dart';
import 'package:medical/src/models/attendance_model.dart';

class UserRepository {
  final UserApiProvider _userApiProvider = UserApiProvider();

  Future<String> changePassword(
      {@required String oldPassword, @required String newPassword}) async {
    return _userApiProvider.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }

  Future<UserModel> getInfo() async {
    return await _userApiProvider.getInfo();
  }

  Future<UserModel> getInfoLocally() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userInfoEncoded = prefs.getString('userInfo');
    if (userInfoEncoded != null) {
      return UserModel.fromJson(json.decode(userInfoEncoded));
    }
    return null;
  }

  Future<void> setInfoLocally(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('userInfo', user.toString());
  }

  Future<bool> isAttendanceTimeIn() async {
    return await _userApiProvider.isAttendanceTimeIn();
  }

  Future<bool> isAttendanceTimeInLocally() async {
    final AttendanceModel attendanceLastTime =
        await getAttendanceLastTimeLocally();
    if (attendanceLastTime != null &&
        attendanceLastTime.timeIn != null &&
        attendanceLastTime.timeOut == null) {
      return true;
    }
    return false;
  }

  Future<AttendanceModel> getAttendanceLastTime() async {
    return await _userApiProvider.getAttendanceLastTime();
  }

  Future<AttendanceModel> getAttendanceLastTimeLocally() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final attendanceLastTimeEncoded = prefs.getString('attendanceLastTime');
    if (attendanceLastTimeEncoded != null) {
      return AttendanceModel.fromJson(json.decode(attendanceLastTimeEncoded));
    }
    return null;
  }

  Future<void> setAttendanceLastTimeLocally(
      AttendanceModel attendanceLastTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        'attendanceLastTime', attendanceLastTime?.toString());
  }
}
