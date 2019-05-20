import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AttendanceEvent extends Equatable {
  AttendanceEvent([List props = const []]) : super(props);
}
//ham lay danh sach lich su cham cong sau khi chon ngay bat dau, ngay ket thuc
class GetAttendance extends AttendanceEvent {
  final DateTime starDay;
  final DateTime endDay;
  final int offset;
  final int limit;

  GetAttendance({
    @required this.starDay,
    @required this.endDay,
    @required this.offset,
    @required this.limit,
  }) : super([starDay, endDay, offset, limit]);

  @override
  String toString() {
    return "Get list attendance by day";
  }
}