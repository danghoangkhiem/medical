import 'dart:async';

import 'package:bloc/bloc.dart';

import 'home.dart';

import 'package:medical/src/resources/user_repository.dart';
import 'package:medical/src/resources/consumer_repository.dart';

import 'package:medical/src/models/user_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository = UserRepository();
  final ConsumerRepository _consumerRepository = ConsumerRepository();

  @override
  HomeState get initialState => Initial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is UserIdentifier) {
      yield Loading();
      try {
        final UserModel _user = await _userRepository.getInfo();
        await _userRepository.setInfoLocally(_user);
        await _userRepository.setAttendanceLastTimeLocally(
            await _userRepository.getAttendanceLastTime());
        final bool hasAdditionalFieldsLocally =
            await _consumerRepository.hasAdditionalFieldsLocally();
        if (!hasAdditionalFieldsLocally) {
          await _consumerRepository.setAdditionalFieldsLocally(
              await _consumerRepository.getAdditionalFields());
        }
        yield Loaded(user: _user);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
