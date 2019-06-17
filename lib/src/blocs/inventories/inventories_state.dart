import 'package:medical/src/models/inventories_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class InventoriesState extends Equatable {
  InventoriesState([List props = const []]) : super(props);
}

class InventoriesInitial extends InventoriesState {
  @override
  String toString() => 'InventoriesInitial';
}

class InventoriesLoading extends InventoriesState {
  @override
  String toString() => 'InventoriesLoading';
}

class InventoriesLoaded extends InventoriesState {
  final InventoriesModel inventoriesModel;

  List<int> listSum;

  InventoriesLoaded({@required this.inventoriesModel, @required this.listSum}) : super([inventoriesModel, listSum]);

  @override
  String toString() => 'InventoriesLoaded';
}

class InventoriesEmpty extends InventoriesState{

}

class InventoriesFailure extends InventoriesState {
  final String error;

  InventoriesFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'InventoriesFailure { error: $error }';
}





