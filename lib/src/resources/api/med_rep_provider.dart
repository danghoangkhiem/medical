import 'package:medical/src/models/medrep_of_medsup_model.dart';
import 'package:medical/src/resources/api/api_response_error.dart';

import 'api_provider.dart';


class MedRepApiProvider extends ApiProvider {

  Future<MedRepModel> getMedRep({int offset = 0, int limit = 10}) async {

    await Future.delayed(Duration(milliseconds: 200));

    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit
    };

    Response _resp = await httpClient.get('/users',
        queryParameters: _queryParameters);

    if (_resp.statusCode == 200) {
      return MedRepModel.fromJson(_resp.data["data"]);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));




    //    return MedRepModel.fromJson([
//      {
//        "name": "BS. Trần Văn Lượng",
//      },
//      {
//        "name": "Trịnh Quốc Thông"
//      },
//      {
//        "name": "Trịnh Quốc Thông 2"
//      },
//      {
//        "name": "Trịnh Quốc Thông 3"
//      },
//      {
//        "name": "Trịnh Quốc Thông 4"
//      },
//      {
//        "name": "Trịnh Quốc Thông 5"
//      },
//      {
//        "name": "Trịnh Quốc Thông 6"
//      },
//      {
//        "name": "Trịnh Quốc Thông 3"
//      },
//      {
//        "name": "Trịnh Quốc Thông 4"
//      },
//      {
//        "name": "Trịnh Quốc Thông 5"
//      },
//      {
//        "name": "Trịnh Quốc Thông 6"
//      },
//
//    ]);

  }

}



