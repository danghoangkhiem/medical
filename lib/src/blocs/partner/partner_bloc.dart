import 'dart:async';

import 'package:bloc/bloc.dart';

import 'partner.dart';

import 'package:medical/src/models/partner_model.dart';

import 'package:medical/src/resources/place_repository.dart';

class PartnerBloc extends Bloc<PartnerEvent, PartnerState> {
  PlaceRepository _placeRepository = PlaceRepository();

  @override
  PartnerState get initialState => Initial();

  @override
  Stream<PartnerState> mapEventToState(
    PartnerEvent event,
  ) async* {
    if (event is FetchData) {
      yield Loading();
      try {
        var _partners = PartnerListModel.fromJson([]);
        var _result;
        var _limit = 20;
        do {
          _result = await _placeRepository.partnersAccordingToPlace(
            event.placeId,
            offset: _partners.length,
            limit: _limit,
          );
          _partners.addAll(_result);
        } while (_result != null && _result.length == _limit);
        yield Success(partners: _partners);
      } catch (error) {
        yield Failure(error: error.toString());
      }
    }
  }
}
