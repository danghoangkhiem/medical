import 'package:bloc/bloc.dart';
import 'package:medical/src/blocs/inventories/inventories_event.dart';
import 'package:medical/src/blocs/inventories/inventories_state.dart';
import 'package:medical/src/resources/inventories_repository.dart';
import '../../models/models.dart';

import 'package:meta/meta.dart';

class InventoriesBloc extends Bloc<InventoriesEvent, InventoriesState> {
  final InventoriesRepository _inventoriesRepository;

  InventoriesBloc({
    @required inventoriesRepository,
  }) : _inventoriesRepository = inventoriesRepository;

  @override
  InventoriesState get initialState => InventoriesInitial();

  @override
  Stream<InventoriesState> mapEventToState(InventoriesEvent event) async* {
    if (event is GetInventories) {
      yield InventoriesLoading();
      try {
        InventoriesModel inventories =
            await _inventoriesRepository.getInventories(
                startDay: event.starDay,
                endDay: event.endDay,
                value: event.value);
        int sumImport = 0;
        int sumExport = 0;
        int sumStock = 0;

        if (inventories.listInventories.length == 0) {
          yield InventoriesEmpty();
        } else {
          inventories.listInventories.forEach((item) {
            sumImport += item.import;
            sumExport += item.export;
            sumStock += item.stock;
          });

          List<int> listSum = [];
          listSum.add(sumImport);
          listSum.add(sumExport);
          listSum.add(sumStock);

          yield InventoriesLoaded(
              inventoriesModel: inventories, listSum: listSum);
        }
      } catch (error) {
        yield InventoriesFailure(error: error.toString());
      }
    }
  }
}
