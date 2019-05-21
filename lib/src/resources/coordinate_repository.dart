import 'package:medical/src/models/coordinate_model.dart';

class CoordinateRepository {
  Future<CoordinateModel> getCoordinate() async {
    await Future.delayed(Duration(seconds: 2));
    return CoordinateModel.fromJson({'lat': 10.7797855, 'lon': 106.6990189});
  }
}
