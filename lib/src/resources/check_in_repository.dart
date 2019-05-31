import 'package:medical/src/models/check_in_model.dart';
import 'package:medical/src/models/check_out_model.dart';
import 'package:medical/src/resources/api/check_in_api_provider.dart';

class CheckInRepository {
  final CheckInApiProvider _checkInApiProvider = CheckInApiProvider();

  Future addCheckIn(CheckInModel newCheckIn) async {
    return await _checkInApiProvider.addCheckIn(checkIn: newCheckIn);
  }

  Future checkIO() async {
    return await _checkInApiProvider.checkIO();
  }

  Future addCheckOut(CheckOutModel newCheckOut) async {
    return await _checkInApiProvider.addCheckOut(checkOut: newCheckOut);
  }
}
