class AttendancesModel{
  List<AttendanceItem> listAttendance;

  AttendancesModel(this.listAttendance);

  factory AttendancesModel.fromJson(List<dynamic> json){
    List<AttendanceItem> mapAttendance = List<AttendanceItem>.from(json.map((item){
      return AttendanceItem.fromJson(item);
    }));

    return AttendancesModel(mapAttendance.toList());

  }

}

class Location{
  final int id;
  final String name;

  Location({this.id, this.name});

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      id: json["id"],
      name: json["name"]
    );
  }
}

class AttendanceItem{

  final Location location;
  final DateTime timeIn;
  final DateTime timeOut;

  AttendanceItem({this.location, this.timeIn, this.timeOut});

  factory AttendanceItem.fromJson(Map<String, dynamic> json){
    return AttendanceItem(
        location: Location.fromJson(json["location"]),
        timeIn: json["timeIn"] !=null  ? DateTime.fromMillisecondsSinceEpoch(json["timeIn"] * 1000) : null ,
        timeOut: json["timeOut"] !=null ? DateTime.fromMillisecondsSinceEpoch(json["timeOut"] * 1000) : null
    );
  }

}