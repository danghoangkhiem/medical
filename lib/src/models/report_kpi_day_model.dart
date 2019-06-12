class ReportKpiDateModel{
  List<ReportKpiDayItemModel> listKpiDayItem;

  ReportKpiDateModel(this.listKpiDayItem);

  factory ReportKpiDateModel.fromJson(List<dynamic> json){
    List<ReportKpiDayItemModel> mapKpiDayItem = List<ReportKpiDayItemModel>.from(json.map((item){
      return ReportKpiDayItemModel.fromJson(item);
    }));

    return ReportKpiDateModel(mapKpiDayItem.toList());
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