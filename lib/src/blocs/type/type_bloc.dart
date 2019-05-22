import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/type/type_event.dart';
import 'package:medical/src/blocs/type/type_state.dart';
import 'package:medical/src/models/type_model.dart';
import 'package:medical/src/resources/type_repository.dart';
import 'package:meta/meta.dart';

class TypeBloc extends Bloc<TypeEvent, TypeState> {

  final TypeRepository _typeRepository;

  TypeBloc({
    @required typeRepository,
  }) : _typeRepository = typeRepository;

  @override
  TypeState get initialState => TypeInitial();

  @override
  Stream<TypeState> mapEventToState(TypeEvent event) async* {
    if (event is GetType) {
      yield TypeLoading();
      try {
        TypeModel typeModel = await _typeRepository.getType();
        yield TypeLoaded(type: typeModel);
      } catch (error) {
        yield TypeFailure(error: error.toString());
      }
    }
  }
}