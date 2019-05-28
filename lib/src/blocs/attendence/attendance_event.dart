import 'package:equatable/equatable.dart';
import 'package:medical/src/models/models.dart';
import 'package:meta/meta.dart';

abstract class AttendanceEvent extends Equatable {
  AttendanceEvent([List props = const []]) : super(props);
}
//ham lay danh sach lich su cham cong sau khi chon ngay bat dau, ngay ket thuc
class GetAttendance extends AttendanceEvent {
  final DateTime startDate;
  final DateTime endDate;
  final int offset;
  final int limit;

  GetAttendance({
    @required this.startDate,
    @required this.endDate,
    @required this.offset,
    @required this.limit,
  }) : super([startDate, endDate, offset, limit]);



  @override
  String toString() {
    return "Get list attendance by day";
  }
}

class GetAttendanceMore extends AttendanceEvent {
  final AttendancesModel attendance;
  final DateTime startDate;
  final DateTime endDate;
  final int offset;
  final int limit;

  GetAttendanceMore({
    @required this.attendance,
    @required this.startDate,
    @required this.endDate,
    @required this.offset,
    @required this.limit,
  }) : super([ attendance,startDate, endDate, offset, limit]);



  @override
  String toString() {
    return "Get list attendance by day";
  }
}