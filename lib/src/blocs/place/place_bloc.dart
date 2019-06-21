import 'dart:async';

import 'package:bloc/bloc.dart';

import 'place.dart';

import 'package:medical/src/models/place_model.dart';

import 'package:medical/src/resources/place_repository.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlaceRepository _placeRepository = PlaceRepository();

  @override
  PlaceState get initialState => Initial();

  @override
  Stream<PlaceState> mapEventToState(
    PlaceEvent event,
  ) async* {
    if (event is FetchData) {
      yield Loading();
      try {
        var _places = PlaceListModel.fromJson([]);
        var _result;
        var _limit = 20;
        do {
          _result = await _placeRepository.places(
            offset: _places.length,
            limit: _limit,
          );
          _places.addAll(_result);
        } while (_result != null && _result.length == _limit);
        yield Success(places: _places);
      } catch (error) {
        yield Failure(error: error.toString());
      }
    }
  }
}
