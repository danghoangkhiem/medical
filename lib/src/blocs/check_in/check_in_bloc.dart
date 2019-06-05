import 'dart:async';
import 'package:bloc/bloc.dart';

import 'check_in.dart';
import 'package:medical/src/resources/user_repository.dart';

import 'package:medical/src/resources/check_in_repository.dart';
import 'package:medical/src/models/attendance_model.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final CheckInRepository _checkInRepository = CheckInRepository();
  final UserRepository _userRepository = UserRepository();

  @override
  CheckInState get initialState => CheckInInitial();

  @override
  Stream<CheckInState> mapEventToState(CheckInEvent event) async* {
    if (event is AddCheckIn) {
      yield CheckInLoading();
      try {
        final result =
            await _checkInRepository.addCheckIn(event.newCheckInModel);
        yield CheckInLoaded();
      } catch (error) {
        yield CheckInFailure(error: error.toString());
      }
    }
    if (event is CheckIO) {
      yield CheckIOLoading();
      try {
        bool isCheckIn = await _userRepository.isAttendanceTimeInLocally();
        AttendanceModel attendanceModel = await _userRepository.getAttendanceLastTimeLocally();
        yield CheckIOLoaded(isCheckIn: isCheckIn,attendanceModel: attendanceModel);
      } catch (error, stack) {
        yield CheckIOFailure(error: error.toString());
      }
    }
    if (event is AddCheckOut) {
      yield CheckOutLoading();
      try {
        final result =
        await _checkInRepository.addCheckOut(event.newCheckOutModel);
        yield CheckOutLoaded();
      } catch (error) {
        yield CheckOutFailure(error: error.toString());
      }
    }
  }
}
