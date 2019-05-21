import 'package:medical/src/models/check_in_model.dart';

class CheckInRepository {
  Future addCheckIn(CheckInModel newCheckIn) async {
    print(newCheckIn.locationId);
    print(newCheckIn.lat);
    print(newCheckIn.lon);
    print(newCheckIn.images);
    return true;
  }
}
