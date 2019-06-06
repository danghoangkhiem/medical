import 'package:meta/meta.dart';
import 'package:medical/src/models/customer_manage_model.dart';
import 'package:medical/src/resources/database/consumer_db_provider.dart';
import 'package:medical/src/resources/api/customer_api_provider.dart';

class CustomerManageRepository {

  final ConsumerDbProvider _consumerDbProvider = ConsumerDbProvider();
  final CustomerApiProvider _customerApiProvider = CustomerApiProvider();


  Future<CustomerManagerListModel> getCustomerByTypeAndStatus(int timeIn, int offset, int limit,@required String type,@required String status) async {
    return await _customerApiProvider.getCustomerByTypeAndStatus(timeIn: timeIn,offset: offset, limit: limit,type: type,status: status);
  }

  Future<CustomerManagerListModel> getCustomers(int timeIn, int userId, int offset, int limit,String type) async {
    await Future.delayed(Duration(seconds: 1));
    return await _consumerDbProvider.getListCustomer(timeIn, userId, offset, limit, type);
  }
}