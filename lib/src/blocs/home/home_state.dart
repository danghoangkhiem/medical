import 'package:meta/meta.dart';

import 'package:medical/src/models/user_model.dart';

@immutable
abstract class HomeState {}

class Initial extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  final UserModel user;

  Loaded({@required this.user});
}

class Failure extends HomeState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}