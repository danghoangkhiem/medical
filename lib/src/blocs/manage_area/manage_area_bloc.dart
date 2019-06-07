import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/manage_area/manage_area_event.dart';
import 'package:medical/src/blocs/manage_area/manage_area_state.dart';
import 'package:medical/src/resources/manage_area_repository.dart';
import 'package:meta/meta.dart';

class ManageAreaBloc extends Bloc<ManageAreaEvent, ManageAreaState> {

  DateTime _date;
  int _currentOffset;
  int _currentLimit;

  final ManageAreaRepository _manageAreaRepository;

  ManageAreaBloc({
    @required manageAreaRepository,
  }) : _manageAreaRepository = manageAreaRepository;

  @override
  ManageAreaState get initialState => ManageAreaInitial();

  @override
  Stream<ManageAreaState> mapEventToState(ManageAreaEvent event) async* {
    if (event is GetManageArea) {
      yield ManageAreaLoading();
      try {
        if (event.date == null) {
          throw 'Phải chọn thời gian';
        }

        final manageArea = await _manageAreaRepository.getManageArea(
            offset: _currentOffset = event.offset,
            limit: _currentLimit = event.limit,
            date: _date = event.date,

        );

        if(manageArea.listManageArea.length == 0){
          print("ko co du lieu");
          yield ManageAreaEmpty();
        }

        yield ManageAreaLoaded(manageArea: manageArea);
      } catch (error, stack) {
        print(stack);
        yield ManageAreaFailure(error: error.toString());
      }
    }

    if (event is LoadMore) {
      yield ManageAreaLoading(isLoadMore: true);
      try {
        final manageArea = await _manageAreaRepository.getManageArea(
            offset: _currentOffset  = _currentOffset + _currentLimit,
            limit: _currentLimit,
            date: _date
        );

        if (manageArea.listManageArea.length == 0) {
          yield ReachMax();
        } else {
          yield ManageAreaLoaded(manageArea: manageArea, isLoadMore: true);
        }
      } catch (error) {
        yield ManageAreaFailure(error: error.toString());
      }
    }

  }

}