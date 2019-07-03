class ReportKpiDateModel {
  List<ReportKpiDateItemModel> listKpiDateItem;

  ReportKpiDateModel(this.listKpiDateItem);

  factory ReportKpiDateModel.fromJson(List<dynamic> json) {
    List<ReportKpiDateItemModel> mapKpiDateItem;

    if (json != null) {
      mapKpiDateItem = List<ReportKpiDateItemModel>.from(json.map((item) {
        return ReportKpiDateItemModel.fromJson(item);
      }));

      return ReportKpiDateModel(mapKpiDateItem.toList());
    } else {
      return ReportKpiDateModel(null);
    }
  }
}

class ReportKpiDateItemModel {
  final DateTime date;
  final int countVisit;

  ReportKpiDateItemModel({this.date, this.countVisit});

  factory ReportKpiDateItemModel.fromJson(Map<String, dynamic> json) {
    return ReportKpiDateItemModel(
        date: DateTime.fromMillisecondsSinceEpoch(json["date"] * 1000) ,
        countVisit: json["count"]);
  }
}
