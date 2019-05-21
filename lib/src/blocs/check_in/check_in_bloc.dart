import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'check_in.dart';

import 'package:medical/src/resources/check_in_repository.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final CheckInRepository _checkInRepository = CheckInRepository();

  @override
  CheckInState get initialState => CheckInInitial();

  @override
  Stream<CheckInState> mapEventToState(CheckInEvent event) async* {
    if (event is AddCheckIn) {
      yield CheckInLoading();
      try {
        final title = 'OK';
        await _checkInRepository.addCheckIn(event.newCheckInModel);
        yield CheckInLoaded(title: title);
      } catch (error) {
        yield CheckInFailure(error: error.toString());
      }
    }
  }
}
