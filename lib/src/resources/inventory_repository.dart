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
        "owner": "Nguyễn Văn A",
        "status": "approved",
        "items": {
          "samples": [],
          "gifts": [],
          "posm": [
            {"key": 1, "label": "Túi giấy", "quantity": 10},
            {"key": 2, "label": "Bút", "quantity": 10},
            {"key": 3, "label": "Tờ rơi", "quantity": 10},
            {"key": 4, "label": "Áo mưa", "quantity": 10},
          ]
        }
      };
    }).toList());
  }

  Future<bool> updateInvoiceStatus(int invoiceId,
      {@required InvoiceStatus status}) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}
