import 'package:medical/src/models/day_schedule_med_rep_model.dart';
import 'package:medical/src/resources/api/manage_area_api_provider.dart';

class ManageAreaRepository {

  final ManageAreaApiProvider _manageAreaApiProvider = ManageAreaApiProvider();

  Future<DayScheduleMedRepModel> getManageArea({DateTime date, int offset, int limit}) async {
    return await _manageAreaApiProvider.getManageArea(offset: offset, limit: limit, date: date);
  }

}