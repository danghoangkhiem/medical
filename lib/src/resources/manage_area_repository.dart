import 'package:medical/src/models/manage_area_model.dart';
import 'package:medical/src/resources/api/manage_area_api_provider.dart';

class ManageAreaRepository {

  final ManageAreaApiProvider _manageAreaApiProvider = ManageAreaApiProvider();

  Future<ManageAreaModel> getManageArea({DateTime date, int offset, int limit}) async {
    return await _manageAreaApiProvider.getManageArea(offset: offset, limit: limit, date: date);
  }

}