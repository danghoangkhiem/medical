class ReportKpiDayModel{
  List<ReportKpiDayItemModel> listKpiDayItem;

  ReportKpiDayModel(this.listKpiDayItem);

  factory ReportKpiDayModel.fromJson(List<dynamic> json){
    List<ReportKpiDayItemModel> mapKpiDayItem = List<ReportKpiDayItemModel>.from(json.map((item){
      return ReportKpiDayItemModel.fromJson(item);
    }));

    return ReportKpiDayModel(mapKpiDayItem.toList());
  }
}

class ReportKpiDayItemModel{
  final DateTime date;
  final int countVisit;

  ReportKpiDayItemModel({this.date, this.countVisit});

  factory ReportKpiDayItemModel.fromJson(Map<String, dynamic> json){
    return ReportKpiDayItemModel(
      date: DateTime.fromMillisecondsSinceEpoch(json["date"])  ,
      countVisit: json["countVisit"]
    );
  }


}