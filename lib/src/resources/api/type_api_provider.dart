import 'package:medical/src/models/type_model.dart';
import 'api_provider.dart';

class TypeApiProvider extends ApiProvider {

  Future<TypeModel> getType() async {
    return TypeModel.fromJson([
      {
        "id": 1,
        "name": "gift"
      },
      {
        "id": 2,
        "name": "sampling"
      },
      {
        "id": 3,
        "name": "posm"
      }
    ]);
  }
}



