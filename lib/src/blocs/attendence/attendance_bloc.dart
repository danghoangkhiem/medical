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
      yield AttendanceLoading();

      try {
        AttendancesModel attendance = await _attendanceRepository.getAttendance(startDate: event.startDate, endDate: event.endDate, offset: event.offset, limit: event.limit);
        yield AttendanceLoaded(attendance: attendance);
      } catch (error) {
        yield AttendanceFailure(error: error.toString());
      }
    }

    if(event is GetAttendanceMore){
      yield AttendanceLoaded(attendance: event.attendance, isLoadingMore: true);
      try{
        AttendancesModel attendanceMore = await _attendanceRepository.getAttendanceMore(startDay: event.startDate, endDay: event.endDate, offset: event.offset, limit: event.limit);
        print(attendanceMore.listAttendance.length);
        AttendancesModel oldAttendanceModel = event.attendance;

        if(attendanceMore !=null){
          oldAttendanceModel.listAttendance.addAll(attendanceMore.listAttendance);
          print(oldAttendanceModel.listAttendance.length);
        }

        print(oldAttendanceModel.listAttendance);
        yield AttendanceLoaded(attendance: oldAttendanceModel, isLoadingMore: false);

      }catch(error){
        yield AttendanceFailure(error: error.toString());
      }

    }
  }

}