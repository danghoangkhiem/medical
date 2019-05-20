import 'dart:async';

import 'package:bloc/bloc.dart';

import 'check_in.dart';

import '../../resources/attendance_repository.dart';
import '../../resources/location_repository.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final LocationRepository _locationRepository = LocationRepository();
  final AttendanceRepository _attendanceRepository = AttendanceRepository();

  @override
  CheckInState get initialState => CheckInInitial();

  @override
  Stream<CheckInState> mapEventToState(CheckInEvent event) async* {
    if (event is GetLocation) {
      yield CheckInLocationLoading();
      try {
        final locationList = await _locationRepository.getLocations();
        yield CheckInLocationLoaded(locationList: locationList);
      } catch (error) {
        yield CheckInLocationFailure(error: error.toString());
      }
    }
  }
}
