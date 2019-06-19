import 'package:medical/src/models/medrep_of_medsup_model.dart';
import 'package:medical/src/resources/api/api_response_error.dart';
import 'package:meta/meta.dart';

import 'api_provider.dart';


class MedRepApiProvider extends ApiProvider {

  Future<MedRepModel> getMedRep({int offset = 0, int limit = 10, @required int id}) async {


    return MedRepModel.fromJson([
      {
        "name": "BS. Trần Văn Lượng",
        "hospital": "Bv. Bình Thạnh"
      }
    ]);




//    Map<String, dynamic> _queryParameters = {
//      'offset': offset,
//      'limit': limit,
//      'code': id
//    };
//
//    Response _resp = await httpClient.get('/attendances/attendances',
//        queryParameters: _queryParameters);
//
//    if (_resp.statusCode == 200) {
//      return MedRepModel.fromJson(_resp.data["data"]);
//    }
//    return Future.error(ApiResponseError.fromJson(_resp.data));

  }

}



