
import 'package:medical/src/resources/api/inventories_api_provider.dart';

import '../models/models.dart';

class InventoriesRepository {

  final InventoriesApiProvider _inventoriesApiProvider = InventoriesApiProvider();

  Future<InventoriesModel> getInventories({DateTime startDay, DateTime endDay, int value}) async {
    return await _inventoriesApiProvider.getInventories(startDate: startDay, endDate: endDay, value: value);
  }

//  Future<InventoriesModel> getInventoriesSampling({DateTime startDay, DateTime endDay, int value}) async {
//    return await _inventoriesApiProvider.getInventoriesSampling(startDay: startDay, endDay: endDay, value: value);
//  }

//  Future<InventoriesModel> getInventoriesPosm({DateTime startDay, DateTime endDay, int value}) async {
//    return await _inventoriesApiProvider.getInventoriesPosm(startDay: startDay, endDay: endDay, value: value);
//  }

}