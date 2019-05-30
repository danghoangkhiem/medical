import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/attendence/attendance_event.dart';
import 'package:medical/src/blocs/attendence/attendance_state.dart';
import 'package:medical/src/resources/attendance_repository.dart';
import 'package:meta/meta.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {

  DateTime _currentStartDate;
  DateTime _currentEndDate;
  int _currentOffset;
  int _currentLimit;

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
        if (event.startDate == null || event.endDate == null) {
          throw 'Phải chọn thời gian';
        }

        final attendance = await _attendanceRepository.getAttendance(
            offset: _currentOffset = event.offset,
            limit: _currentLimit = event.limit,
            startDate: _currentStartDate = event.startDate,
            endDate: _currentEndDate = event.endDate
        );
        print("ok");
        print(attendance);
        yield AttendanceLoaded(attendance: attendance);
      } catch (error, stack) {
        print(stack);
        yield AttendanceFailure(error: error.toString());
      }
    }

    if (event is LoadMore) {
      yield AttendanceLoading(isLoadMore: true);
      try {
        final attendance = await _attendanceRepository.getAttendance(
            offset: _currentOffset  = _currentOffset + _currentLimit,
            limit: _currentLimit,
            startDate: _currentStartDate ,
            endDate: _currentEndDate
        );

        if (attendance.listAttendance.length == 0) {
          yield ReachMax();
        } else {
          yield AttendanceLoaded(attendance: attendance, isLoadMore: true);
        }
      } catch (error) {
        yield AttendanceFailure(error: error.toString());
      }
    }

  }

}