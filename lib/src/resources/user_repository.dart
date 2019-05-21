class UserRepository {
  authenticate({String username, String password}) async {
    await Future.delayed(Duration(seconds: 1));
  }

  changePassword({String oldPassword, String newPassword}) async {
    await Future.delayed(Duration(seconds: 1));
  }
}