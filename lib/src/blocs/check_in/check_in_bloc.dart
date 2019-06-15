import 'dart:async';
import 'package:bloc/bloc.dart';

import 'check_in.dart';
import 'package:medical/src/resources/user_repository.dart';

import 'package:medical/src/resources/check_in_repository.dart';
import 'package:medical/src/models/attendance_model.dart';
import 'package:medical/src/models/check_io_model.dart';
import 'package:medical/src/models/location_model.dart';
import 'package:medical/src/resources/location_repository.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final CheckInRepository _checkInRepository = CheckInRepository();
  final UserRepository _userRepository = UserRepository();
  final LocationRepository _locationRepository = LocationRepository();

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
        final locationList = await _locationRepository.getLocations();
        bool isCheckIn = await _userRepository.isAttendanceTimeInLocally();
        AttendanceModel attendanceModel =
            await _userRepository.getAttendanceLastTimeLocally();
        yield CheckIOLoaded(
            isCheckIn: isCheckIn, attendanceModel: attendanceModel,locationList: locationList);
      } catch (error) {
        yield CheckIOFailure(error: error.toString());
      }
    }
    if (event is AddCheckOut) {
      yield CheckOutLoading();
      try {
        bool checkIOModel = await _checkInRepository.addCheckOut(event.newCheckOutModel);
        await _checkInRepository.addCheckOut(event.newCheckOutModel);
        await _userRepository.setAttendanceLastTimeLocally(
            await _userRepository.getAttendanceLastTime());
        if (checkIOModel == false) {
          yield CheckOutError();
        } else {
          yield CheckOutLoaded();
        }
      } catch (error) {
        yield CheckOutFailure(error: error.toString());
      }
    }
  }
}
