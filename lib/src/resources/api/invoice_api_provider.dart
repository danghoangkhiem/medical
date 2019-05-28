import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/invoice_model.dart';

class InvoiceApiProvider extends ApiProvider {
  Future<InvoiceListModel> getInvoiceAccordingToDateTime(
      {int offset = 10,
      int limit = 0,
      @required DateTime startDate,
      @required DateTime endDate}) async {
    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
      'startDate':
          DateTime(startDate.year, startDate.month, startDate.day, 00, 00, 00)
                  .millisecondsSinceEpoch ~/
              1000,
      'endDate':
          DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59)
                  .millisecondsSinceEpoch ~/
              1000
    };
    Response _resp = await httpClient.get('/inventories/invoices',
        queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return InvoiceListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data['error']));
  }

  Future<bool> updateInvoiceStatus(int invoiceId,
      {@required InvoiceStatus status}) async {
    Map<String, dynamic> _requestBody = {
      'status': status.value,
    };
    Response _resp = await httpClient.patch('/inventories/invoices/$invoiceId',
        data: _requestBody);
    if (_resp.statusCode == 200) {
      return true;
    }
    return Future.error(ApiResponseError.fromJson(_resp.data['error']));
  }
}
