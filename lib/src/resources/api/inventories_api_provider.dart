import 'api_provider.dart';

import '../../models/models.dart';

class InventoriesApiProvider extends ApiProvider {

  Future<InventoriesModel> getInventoriesGift({DateTime startDay, DateTime endDay, int value}) async {
    await Future.delayed(Duration(seconds: 1));
    return InventoriesModel.fromJson([
      {
        "key": "ASD123",
        "label": "Qua 1 gift",
        "import": 20,
        "export": 7,
        "stock": 14
      },
      {
        "key": "ASD124",
        "label": "Qua 2 gift",
        "import": 14,
        "export": 7,
        "stock": 7
      },
    ]);
  }

  Future<InventoriesModel> getInventoriesSampling({DateTime startDay, DateTime endDay, int value}) async {
    await Future.delayed(Duration(seconds: 1));
    return InventoriesModel.fromJson([
      {
        "key": "ASD123",
        "label": "Qua 3 sampling",
        "import": 20,
        "export": 7,
        "stock": 14
      },
      {
        "key": "ASD124",
        "label": "Qua 4 sampling",
        "import": 14,
        "export": 7,
        "stock": 7
      },
    ]);
  }

  Future<InventoriesModel> getInventoriesPosm({DateTime startDay, DateTime endDay, int value}) async {
    await Future.delayed(Duration(seconds: 1));
    return InventoriesModel.fromJson([
      {
        "key": "ASD123",
        "label": "Qua 5 posm",
        "import": 20,
        "export": 7,
        "stock": 14
      },
      {
        "key": "ASD124",
        "label": "Qua 6 posm",
        "import": 14,
        "export": 7,
        "stock": 7
      },
    ]);
  }

}



