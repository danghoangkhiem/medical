import 'package:medical/src/models/kpi_date_detail_model.dart';
import 'api_provider.dart';


class KpiDateDetailProvider extends ApiProvider {

  Future<ReportKpiDayDetailModel> getKpiDateDetail({DateTime byDate}) async {
    await Future.delayed(Duration(seconds: 1));
    return ReportKpiDayDetailModel.fromJson([
      {
        "name": "BS. Trần Văn Lượng",
        "hospital": "Bv. Bình Thạnh"
      },
      {
        "name": "BS. Trần Văn Lượng",
        "hospital": "Bv. Bình Thạnh 2"
      },
      {
        "name": "BS. Trần Văn Lượng",
        "hospital": "Bv. Bình Thạnh 3"
      },
      {
        "name": "BS. Trần Văn Lượng",
        "hospital": "Bv. Bình Thạnh 4"
      }
    ]);
  }

}



