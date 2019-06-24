
import 'package:medical/src/models/partner_model.dart';

class DayScheduleMedRepModel{
  List<DayScheduleMedRepItem> listDayScheduleMedRep;

  DayScheduleMedRepModel(this.listDayScheduleMedRep);

  factory DayScheduleMedRepModel.fromJson(List<dynamic> json){
    List<DayScheduleMedRepItem> mapDayScheduleMedRep = List<DayScheduleMedRepItem>.from(json.map((item){
      return DayScheduleMedRepItem.fromJson(item);
    }));

    return DayScheduleMedRepModel(mapDayScheduleMedRep.toList());
  }
}

class DayScheduleMedRepItem{

final int id;
final DateTime startTime;
final DateTime endTime;
final PartnerModel partnerModel;
//final DateTime realStartTime;
//final DateTime realEndTime;

//final String doctorName;

//final String addressType;
//final String addressName;
//final int status;

//final String targetBefore;
//final String targetAfter;


DayScheduleMedRepItem({this.id, this.endTime, this.startTime, this.partnerModel });

//  ManageAreaItem({this.id, this.startTime, this.endTime, this.realStartTime,
//    this.realEndTime, this.doctorName, this.addressType, this.addressName,
//    this.status, this.targetBefore, this.targetAfter});

factory DayScheduleMedRepItem.fromJson(Map<String, dynamic> json){
    return DayScheduleMedRepItem(
        id: json["id"],
        startTime: json["hours"]["from"] !=null  ? DateTime.fromMillisecondsSinceEpoch(json["hours"]["from"] * 1000) : null ,
        endTime: json["hours"]["end"] !=null  ? DateTime.fromMillisecondsSinceEpoch(json["hours"]["end"] * 1000) : null ,
        partnerModel: PartnerModel.fromJson(json["partner"])
      //realStartTime: json["realStartTime"] !=null  ? DateTime.fromMillisecondsSinceEpoch(json["realStartTime"] * 1000) : null ,
      //realEndTime: json["realEndTime"] !=null  ? DateTime.fromMillisecondsSinceEpoch(json["realEndTime"] * 1000) : null ,
//      doctorName: json["doctorName"],
//      addressType: json["addressType"],
//      addressName: json["addressName"]
      //status: json["status"],
      //targetBefore: json["targetBefore"],
      //targetAfter: json["targetAfter"]
    );
  }


Map<String, dynamic> toJson() {
  return <String, dynamic>{
    'id': id,
    'startTime': startTime,
    'endTime': endTime
    //'realStartTime': realStartTime,
    //'realEndTime': realEndTime,
//    'doctorName': doctorName,
//    'addressType': addressType,
//    'addressName': addressName,
    //'status': status,
    //'targetBefore': targetBefore,
    //'targetAfter': targetAfter,
  };
}

}