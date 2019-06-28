import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/check_in_model.dart';
import 'package:medical/src/models/check_io_model.dart';
import 'package:medical/src/models/check_out_model.dart';

class CheckInApiProvider extends ApiProvider {
  Future<bool> addCheckIn({@required CheckInModel checkIn}) async {
    print("api");
    print(checkIn.lat);
    print(checkIn.lon);
    FormData formData = new FormData.from({
      "longitude": checkIn.lon == null ? 0 : checkIn.lon,
      "latitude": checkIn.lat == null ? 0 : checkIn.lat,
      "locationId": checkIn.locationId,
      "images": checkIn.images.map((File item) {
        return UploadFileInfo(item, basename(item.path));
      }).toList()
    });
    Response _resp =
        await httpClient.post('/attendances/check-in', data: formData);
    if (_resp.statusCode == 200) {
      try {
        return CheckIOModel.fromJson(_resp.data) == null ? false : true;
      } catch (_) {
        return false;
      }
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<CheckIOModel> checkIO() async {
    Response _resp = await httpClient.get('/attendances/last');
    if (_resp.statusCode == 200) {
      return CheckIOModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<bool> addCheckOut({@required CheckOutModel checkOut}) async {
    Map<String, dynamic> _queryParameters = {
      'latitude': checkOut.latitude == null ? 0 : checkOut.latitude,
      'longitude': checkOut.longitude == null ? 0 : checkOut.longitude,
    };
    Response _resp =
        await httpClient.post('/attendances/check-out', data: _queryParameters);
    if (_resp.statusCode == 200) {
      try {
        return CheckIOModel.fromJson(_resp.data) == null ? false : true;
      } catch (_) {
        return false;
      }
    }/*else{
      return false;
    }*/
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
