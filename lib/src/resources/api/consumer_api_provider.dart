import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/consumer_model.dart';
import 'package:medical/src/models/additional_data_model.dart';

class ConsumerApiProvider extends ApiProvider {
  Future<ConsumerModel> createConsumer(ConsumerModel consumer) async {
    Response _resp =
        await httpClient.post('/consumers', data: consumer.toJson());
    if (_resp.statusCode == 200) {
      return ConsumerModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<ConsumerListModel> getConsumerAccordingToOffset(
      {int offset = 0, int limit = 10}) async {
    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
    };
    Response _resp = await httpClient.get('/consumers',
        queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return ConsumerListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<AdditionalDataModel> getAdditionalFields() async {
    Response _resp = await httpClient.get('/consumers/additional-fields');
    if (_resp.statusCode == 200) {
      return AdditionalDataModel.fromJson({
        "samples": [
          {
            "key": 1,
            "label": "Anmum Choco Concentrate 4X",
            "value": null
          },
          {
            "key": 2,
            "label": "Anmum Vanilla Concentrate 4X",
            "value": null
          },
          {
            "key": 3,
            "label": "Anmum Sachet - Chocolate",
            "value": null
          },
          {
            "key": 4,
            "label": "Anmum Sachet - Vanilla",
            "value": null
          }
        ],
        "gifts": [
          {
            "key": 5,
            "label": "Khăn sữa",
            "value": null
          },
          {
            "key": 6,
            "label": "Túi xách Anmum nhỏ",
            "value": null
          },
          {
            "key": 7,
            "label": "Túi xách Anmum lớn",
            "value": null
          },
          {
            "key": 8,
            "label": "Túi ngủ",
            "value": null
          },
          {
            "key": 9,
            "label": "Vớ tay chân",
            "value": null
          }
        ],
        "posm": [
          {
            "key": 10,
            "label": "Túi Giấy",
            "value": null
          },
          {
            "key": 11,
            "label": "Bút",
            "value": null
          },
          {
            "key": 12,
            "label": "Tờ rơi",
            "value": null
          },
          {
            "key": 13,
            "label": "Áo Mưa",
            "value": null
          }
        ],
        "purchases": [
          {
            "key": 14,
            "label": "Anmum Concentrate 4X",
            "value": null
          },
          {
            "key": 15,
            "label": "Anmum Powder 400g",
            "value": null
          }
        ]
      });
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
