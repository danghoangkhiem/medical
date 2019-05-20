import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/attendence/attendance_event.dart';
import 'package:medical/src/blocs/attendence/attendance_state.dart';
import 'package:medical/src/resources/attendance_repository.dart';
import '../../models/models.dart';


import 'package:meta/meta.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {

  final AttendanceRepository _attendanceRepository;

  AttendanceBloc({
    @required attendanceRepository,
  }) : _attendanceRepository = attendanceRepository;

  @override
  AttendanceState get initialState => AttendanceInitial();

  @override
  Stream<AttendanceState> mapEventToState(AttendanceEvent event) async* {
    if (event is GetAttendance) {
      try {
        yield AttendanceLoading();
        AttendancesModel attendance = await _attendanceRepository.getAttendance(startDay: event.starDay, endDay: event.endDay, offset: event.offset, limit: event.limit);
        yield AttendanceLoaded(attendance: attendance);
      } catch (error) {
        yield AttendanceFailure(error: error.toString());
      }
    }
  }
}