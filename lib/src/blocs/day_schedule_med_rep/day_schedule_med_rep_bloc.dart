import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/day_schedule_med_rep/day_schedule_med_rep_event.dart';
import 'package:medical/src/blocs/day_schedule_med_rep/day_schedule_med_rep_state.dart';
import 'package:medical/src/models/schedule_coaching_model.dart';
import 'package:medical/src/resources/day_schedule_med_rep_repository.dart';
import 'package:medical/src/resources/user_repository.dart';
import 'package:meta/meta.dart';

class DayScheduleMedRepBloc
    extends Bloc<DayScheduleMedRepEvent, DayScheduleMedRepState> {
  DateTime _date;
  int _currentOffset;
  int _currentLimit;
  int _userId;

  final DayScheduleMedRepRepository _dayScheduleMedRepRepository;

  final UserRepository _userRepository = UserRepository();

  DayScheduleMedRepBloc({
    @required dayScheduleMedRepRepository,
  }) : _dayScheduleMedRepRepository = dayScheduleMedRepRepository;

  @override
  DayScheduleMedRepState get initialState => DayScheduleMedRepInitial();

  @override
  Stream<DayScheduleMedRepState> mapEventToState(
      DayScheduleMedRepEvent event) async* {
    if (event is GetDayScheduleMedRep) {


      print(event.date);
      print(event.date.millisecondsSinceEpoch ~/1000);

      yield DayScheduleMedRepLoading();
      try {
        if (event.date == null) {
          throw 'Phải có thời gian';
        }

        print("hakathong........................");
        final dayScheduleMedRep =
            await _dayScheduleMedRepRepository.getDayScheduleMedRep(
                offset: _currentOffset = event.offset,
                limit: _currentLimit = event.limit,
                date: _date = event.date,
                userId: _userId = event.userId);

        print("ok thong trinh");

        print(dayScheduleMedRep);


        if (dayScheduleMedRep.listDayScheduleMedRep.length == 0) {
          print("ko co du lieu");
          yield DayScheduleMedRepEmpty();
        } else {
          yield DayScheduleMedRepLoaded(dayScheduleMedRep: dayScheduleMedRep);
        }
      } catch (error, stack) {
        print(stack);
        yield DayScheduleMedRepFailure(error: error.toString());
      }
    }

    if (event is LoadMore) {
      yield DayScheduleMedRepLoading(isLoadMore: true);
      try {
        final dayScheduleMedRep =
            await _dayScheduleMedRepRepository.getDayScheduleMedRep(
                offset: _currentOffset = _currentOffset + _currentLimit,
                limit: _currentLimit,
                date: _date,
                userId: _userId);

        if (dayScheduleMedRep.listDayScheduleMedRep.length == 0) {
          yield ReachMax();
        } else {
          yield DayScheduleMedRepLoaded(
              dayScheduleMedRep: dayScheduleMedRep, isLoadMore: true);
        }
      } catch (error) {
        yield DayScheduleMedRepFailure(error: error.toString());
      }
    }

    if(event is AddSchedule){
      yield AddScheduleLoading();
      try{
        final user = await _userRepository.getInfoLocally();
        final addScheduleReturn = await _dayScheduleMedRepRepository.createScheduleCoaching(
            userId: user.id,
            date: event.date,
            scheduleId: event.scheduleId,
            from: event.from,
            to: event.to
        );

        if(addScheduleReturn is ScheduleCoachingModel){
          print("thêm thành công");
          yield AddScheduleSuccess();
        }
        else{
          print("Thêm thất bại");
          yield AddScheduleFailure();
        }

      }catch (error){
        yield DayScheduleMedRepFailure(error: error.toString());
      }




    }

  }
}
