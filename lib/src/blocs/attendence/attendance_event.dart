import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AttendanceEvent extends Equatable {
  AttendanceEvent([List props = const []]) : super(props);
}
//ham lay danh sach lich su cham cong sau khi chon ngay bat dau, ngay ket thuc
class GetAttendance extends AttendanceEvent {
  final DateTime starDay;
  final DateTime endDay;

  GetAttendance({
    @required this.starDay,
    @required this.endDay
  }) : super([starDay, endDay]);

  @override
  String toString() {
    return "Get list attendance by day";
  }
}