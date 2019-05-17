class AttendanceItem{

  final String nameHospital;
  final DateTime timeIn;
  final DateTime timeOut;

  AttendanceItem({this.nameHospital, this.timeIn, this.timeOut});

  factory AttendanceItem.fromJson(Map<String, dynamic> json){
    return AttendanceItem(
      nameHospital: json["location"]["name"],
      timeIn: json["timestamps"]["in"],
      timeOut: json["timestamps"]["out"]
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'nameHospital' : nameHospital,
      'timeIn' : timeIn,
      'timeOut' : timeOut
    };
  }

}