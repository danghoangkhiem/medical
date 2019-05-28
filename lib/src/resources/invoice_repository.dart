import 'package:meta/meta.dart';

import 'package:medical/src/models/invoice_model.dart';
import 'package:medical/src/resources/api/invoice_api_provider.dart';

class InvoiceRepository {
  final InvoiceApiProvider _invoiceApiProvider = InvoiceApiProvider();

  Future<InvoiceListModel> getInvoiceAccordingToDateTime(
      {int offset = 10,
      int limit = 0,
      @required DateTime startDate,
      @required DateTime endDate}) async {
    return await _invoiceApiProvider.getInvoiceAccordingToDateTime(
      offset: offset,
      limit: limit,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<bool> updateInvoiceStatus(int invoiceId,
      {@required InvoiceStatus status}) async {
    return await _invoiceApiProvider.updateInvoiceStatus(invoiceId,
        status: status);
  }
}
