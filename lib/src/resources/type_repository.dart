import 'package:medical/src/models/type_model.dart';
import 'package:medical/src/resources/api/type_api_provider.dart';

class TypeRepository {

  final TypeApiProvider _typeApiProvider = TypeApiProvider();

  Future<TypeModel> getType() async {
    return await _typeApiProvider.getType();
  }

}