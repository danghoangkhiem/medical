class UserRepository {
  authenticate({String username, String password}) async {
    await Future.delayed(Duration(seconds: 3));
  }

  changePassword({String oldPassword, String newPassword}) async {
    await Future.delayed(Duration(seconds: 3));
  }
}