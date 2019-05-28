class ReportKpiDayDetailModel{
  List<ReportKpiDayDetailItemModel> listKpiDayDetailItem;

  ReportKpiDayDetailModel(this.listKpiDayDetailItem);

  factory ReportKpiDayDetailModel.fromJson(List<dynamic> json){
    List<ReportKpiDayDetailItemModel> mapKpiDayDetailItem = List<ReportKpiDayDetailItemModel>.from(json.map((item){
      return ReportKpiDayDetailItemModel.fromJson(item);
    }));

    return ReportKpiDayDetailModel(mapKpiDayDetailItem.toList());
  }
}

class ReportKpiDayDetailItemModel{
  final String name;
  final String hospital;

  ReportKpiDayDetailItemModel({this.name, this.hospital});

  factory ReportKpiDayDetailItemModel.fromJson(Map<String, dynamic> json){
    return ReportKpiDayDetailItemModel(
        name: json["name"],
        hospital: json["hospital"]
    );
  }


}