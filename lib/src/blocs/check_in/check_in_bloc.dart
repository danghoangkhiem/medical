import 'dart:async';
import 'package:bloc/bloc.dart';

import 'check_in.dart';
import 'package:medical/src/resources/user_repository.dart';

import 'package:medical/src/resources/check_in_repository.dart';
import 'package:medical/src/models/attendance_model.dart';
import 'package:medical/src/models/check_io_model.dart';

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
        bool checkIOModel = await _checkInRepository.addCheckIn(event.newCheckInModel);
        await _userRepository.setAttendanceLastTimeLocally(
            await _userRepository.getAttendanceLastTime());
        print("haha");
        if (checkIOModel == false) {
          yield CheckInError();
        } else {
          yield CheckInLoaded();
        }
      } catch (error) {
        yield CheckInFailure(error: error.toString());
      }
    }
    if (event is CheckIO) {
      yield CheckIOLoading();
      try {
        bool isCheckIn = await _userRepository.isAttendanceTimeInLocally();
        AttendanceModel attendanceModel =
            await _userRepository.getAttendanceLastTimeLocally();
        yield CheckIOLoaded(
            isCheckIn: isCheckIn, attendanceModel: attendanceModel);
      } catch (error) {
        yield CheckIOFailure(error: error.toString());
      }
    }
    if (event is AddCheckOut) {
      yield CheckOutLoading();
      try {
        await _checkInRepository.addCheckOut(event.newCheckOutModel);
        await _userRepository.setAttendanceLastTimeLocally(
            await _userRepository.getAttendanceLastTime());
        yield CheckOutLoaded();
      } catch (error) {
        yield CheckOutFailure(error: error.toString());
      }
    }
  }
}
