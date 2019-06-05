import 'package:meta/meta.dart';
import 'package:medical/src/models/customer_manage_model.dart';
import 'package:medical/src/resources/database/consumer_db_provider.dart';

class CustomerManageRepository {

  final ConsumerDbProvider _consumerDbProvider = ConsumerDbProvider();


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

  Future<CustomerManagerListModel> getCustomers(int timeIn, int userId) async {
    await Future.delayed(Duration(seconds: 1));
    return await _consumerDbProvider.getListCustomer(timeIn, userId);
  }
}