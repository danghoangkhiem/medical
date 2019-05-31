import 'dart:async';

import 'package:bloc/bloc.dart';

import 'localtion.dart';

import '../../resources/location_repository.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository = LocationRepository();

  @override
  LocationState get initialState => LocationInitial();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is GetLocation) {
      yield LocationLoading();
      try {
        final locationList = await _locationRepository.getLocations();
        yield LocationLoaded(locationList: locationList);
      } catch (error,stack) {
        yield LocationFailure(error: error.toString());
      }
    }
  }
}
