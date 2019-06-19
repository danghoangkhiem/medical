import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/med_rep/med_rep_event.dart';
import 'package:medical/src/blocs/med_rep/med_rep_state.dart';
import 'package:medical/src/resources/med_rep_repository.dart';
import 'package:meta/meta.dart';

class MedRepBloc extends Bloc<MedRepEvent, MedRepState> {
  int _currentId;
  int _currentOffset;
  int _currentLimit;

  final MedRepRepository _medRepRepository;

  MedRepBloc({
    @required medRepRepository,
  }) : _medRepRepository = medRepRepository;

  @override
  MedRepState get initialState => MedRepInitial();

  @override
  Stream<MedRepState> mapEventToState(MedRepEvent event) async* {
    if (event is GetMedRep) {

      yield MedRepLoading();//khi goi ham nay thi isLoading = false;
      try {
        if (event.idMedSup == null) {
          throw 'Phải truyền vài id của med sup';
        }

        final medRep = await _medRepRepository.getMedRep(
            offset: _currentOffset = event.offset,
            limit: _currentLimit = event.limit,
            id: _currentId = event.idMedSup
        );
        if(medRep.listMedRep.length == 0){
          print("ko co du lieu");
          yield MedRepEmpty();
        }

        yield MedRepLoaded(medRep: medRep);
      } catch (error, stack) {
        print(stack);
        yield MedRepFailure(error: error.toString());
      }
    }

    if (event is LoadMore) {
      yield MedRepLoading(isLoadMore: true);
      try {
        final medRep = await _medRepRepository.getMedRep(
            offset: _currentOffset  = _currentOffset + _currentLimit,
            limit: _currentLimit,
            id: _currentId
        );

        if (medRep.listMedRep.length == 0) {
          yield ReachMax();
        } else {
          yield MedRepLoaded(medRep: medRep, isLoadMore: true);
        }
      } catch (error) {
        yield MedRepFailure(error: error.toString());
      }
    }

  }

}