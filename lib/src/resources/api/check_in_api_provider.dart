import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/check_in_model.dart';
import 'package:medical/src/models/check_io_model.dart';
import 'package:medical/src/models/check_out_model.dart';

class CheckInApiProvider extends ApiProvider {
  Future<bool> addCheckIn({@required CheckInModel checkIn}) async {
    FormData formData = new FormData.from({
      "longitude": checkIn.lat,
      "latitude": checkIn.lon,
      "locationId": checkIn.locationId,
      "images": checkIn.images.map((item) {
        return UploadFileInfo(item, "abc.jpg");
      }).toList()
    });
    Response _resp =
        await httpClient.post('/attendances/check-in', data: formData);
    if (_resp.statusCode == 200) {
      return true;
    }
    return Future.error(ApiResponseError.fromJson(_resp.data['error']));
  }

  Future<CheckIOModel> checkIO() async {
    Response _resp = await httpClient.get('/attendances/last');
    if (_resp.statusCode == 200) {
      return CheckIOModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data['error']));
  }

  Future<bool> addCheckOut({@required CheckOutModel checkOut}) async {
    Map<String, dynamic> _queryParameters = {
      'latitude': checkOut.latitude,
      'longitude': checkOut.longitude,
    };
    Response _resp =
        await httpClient.post('/attendances/check-out', data: _queryParameters);
    if (_resp.statusCode == 200) {
      return true;
    }
    return Future.error(ApiResponseError.fromJson(_resp.data['error']));
  }
}
