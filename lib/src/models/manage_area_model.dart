
class ManageAreaModel{
  List<ManageAreaItem> listManageArea;

  ManageAreaModel(this.listManageArea);

  factory ManageAreaModel.fromJson(List<dynamic> json){
    List<ManageAreaItem> mapManageArea = List<ManageAreaItem>.from(json.map((item){
      return ManageAreaItem.fromJson(item);
    }));

    return ManageAreaModel(mapManageArea.toList());

  }


}

class ManageAreaItem{

final int id;
final DateTime startTime;
final DateTime endTime;
final DateTime realStartTime;
final DateTime realEndTime;

final String doctorName;

final String addressType;
final String addressName;
final int status;

final String targetBefore;
final String targetAfter;


ManageAreaItem({this.id, this.startTime, this.endTime, this.realStartTime,
  this.realEndTime, this.doctorName, this.addressType, this.addressName,
  this.status, this.targetBefore, this.targetAfter});

factory ManageAreaItem.fromJson(Map<String, dynamic> json){
    return ManageAreaItem(
      id: json["id"],
        startTime: json["startTime"] !=null  ? DateTime.fromMillisecondsSinceEpoch(json["startTime"] * 1000) : null ,
        endTime: json["endTime"] !=null  ? DateTime.fromMillisecondsSinceEpoch(json["endTime"] * 1000) : null ,
      realStartTime: json["realStartTime"] !=null  ? DateTime.fromMillisecondsSinceEpoch(json["realStartTime"] * 1000) : null ,
      realEndTime: json["realEndTime"] !=null  ? DateTime.fromMillisecondsSinceEpoch(json["realEndTime"] * 1000) : null ,
      doctorName: json["doctorName"],
      addressType: json["addressType"],
      addressName: json["addressName"],
      status: json["status"],
      targetBefore: json["targetBefore"],
      targetAfter: json["targetAfter"]
    );
  }


Map<String, dynamic> toJson() {
  return <String, dynamic>{
    'id': id,
    'startTime': startTime,
    'endTime': endTime,
    'realStartTime': realStartTime,
    'realEndTime': realEndTime,
    'doctorName': doctorName,
    'addressType': addressType,
    'addressName': addressName,
    'status': status,
    'targetBefore': targetBefore,
    'targetAfter': targetAfter,
  };
}

}