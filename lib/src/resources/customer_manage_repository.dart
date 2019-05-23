import 'package:meta/meta.dart';
import 'package:medical/src/models/customer_manage_model.dart';

class CustomerManageRepository {
  Future<CustomerManagerListModel> getCustomerByTypeAndStatus({
    int offset = 10,
    int limit = 0,
    @required String customerType,
    @required String customerStatus
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return CustomerManagerListModel.fromJson(List(10).map((item) {
      return {
        "id": item,
        "name": "Nguyễn Văn A",
        "phone": "0984141645",
      };
    }).toList());
  }
}