import 'package:meta/meta.dart';
import 'package:medical/src/models/invoice_model.dart';

class InventoryRepository {
  Future<InvoiceListModel> getInvoiceAccordingToDateTime({
    int offset = 10,
    int limit = 0,
    @required DateTime startDate,
    @required DateTime endDate
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return InvoiceListModel.fromJson(List(10).map((item) {
      return {
        "id": item,
        "type": "import",
        "date": 1558547173438,
        "status": "approved",
        "items": {
          "samples": [
            {"key": "string", "label": "string", "quantity": 0}
          ],
          "gifts": [
            {"key": "string", "label": "string", "quantity": 0}
          ],
          "posm": [
            {"key": "string", "label": "string", "quantity": 0}
          ]
        }
      };
    }).toList());
  }
}