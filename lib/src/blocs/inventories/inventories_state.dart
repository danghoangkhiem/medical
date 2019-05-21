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

  InventoriesLoaded({@required this.inventoriesModel}) : super([inventoriesModel]);

  @override
  String toString() => 'InventoriesLoaded';
}

class InventoriesFailure extends InventoriesState {
  final String error;

  InventoriesFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'InventoriesFailure { error: $error }';
}