class ReportKpiDateModel {
  List<ReportKpiDateItemModel> listKpiDayItem;

  ReportKpiDateModel(this.listKpiDayItem);

  factory ReportKpiDateModel.fromJson(List<dynamic> json) {
    List<ReportKpiDateItemModel> mapKpiDayItem;

    if (json != null) {
      mapKpiDayItem = List<ReportKpiDateItemModel>.from(json.map((item) {
        return ReportKpiDateItemModel.fromJson(item);
      }));

      return ReportKpiDateModel(mapKpiDayItem.toList());
    } else {
      return null;
    }
  }
}

class ReportKpiDateItemModel {
  final DateTime date;
  final int countVisit;

  ReportKpiDateItemModel({this.date, this.countVisit});

  factory ReportKpiDateItemModel.fromJson(Map<String, dynamic> json) {
    return ReportKpiDateItemModel(
        date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
        countVisit: json["countVisit"]);
  }
}
