import 'package:meta/meta.dart';

import 'api/user_api_provider.dart';

import 'package:medical/src/models/user_model.dart';

class UserRepository {
  final UserApiProvider _userApiProvider = UserApiProvider();

  Future<String> changePassword(
      {@required String oldPassword, @required String newPassword}) async {
    return _userApiProvider.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }

  Future<UserModel> getInfo() async {
    return await _userApiProvider.getInfo();
  }
}
