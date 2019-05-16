import 'package:medical/src/models/attendance_item.dart';

class AttendancesModel{
  List<AttendanceItem> listAttendance;

  AttendancesModel(this.listAttendance);

  factory AttendancesModel.fromJson(List<dynamic> json){
    List<AttendanceItem> mapAttendance = List<AttendanceItem>.from(json.map((item){
      return AttendanceItem.fromJson(item);
    }));

    return AttendancesModel(mapAttendance.toList());

  }

  List<dynamic> toJson(){
    return listAttendance.map((item){
      return item.toJson();
    }).toList();
  }


}