class ReportKpiMonthModel {
  List<ReportKpiMonthItemModel> listKpiMonthItem;

  ReportKpiMonthModel(this.listKpiMonthItem);

  factory ReportKpiMonthModel.fromJson(List<dynamic> json) {
    List<ReportKpiMonthItemModel> mapKpiMonthItem;
    if (json != null) {
      mapKpiMonthItem = List<ReportKpiMonthItemModel>.from(json.map((item) {
        return ReportKpiMonthItemModel.fromJson(item);
      }));
      return ReportKpiMonthModel(mapKpiMonthItem.toList());
    } else {
      return ReportKpiMonthModel(null);
    }
  }
}

class ReportKpiMonthItemModel {
  final String name;
  final String type;
  final int count;

  ReportKpiMonthItemModel({this.name, this.type, this.count});

  factory ReportKpiMonthItemModel.fromJson(Map<String, dynamic> json) {
    return ReportKpiMonthItemModel(
        name: json["partnerName"],
        type: json["type"],
        count: json["count"]);
  }
}
