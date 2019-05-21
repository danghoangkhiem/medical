import 'package:equatable/equatable.dart';

abstract class InventoriesEvent extends Equatable {
  InventoriesEvent([List props = const []]) : super(props);
}

class GetInventoriesGift extends InventoriesEvent {
  final DateTime starDay;
  final DateTime endDay;
  final int value;

  GetInventoriesGift({this.starDay, this.endDay, this.value}) : super([starDay, endDay, value]);

  @override
  String toString() {
    return "Get list inventories";
  }

}

class GetInventoriesSampling extends InventoriesEvent {
  final DateTime starDay;
  final DateTime endDay;
  final int value;

  GetInventoriesSampling({this.starDay, this.endDay, this.value}) : super([starDay, endDay, value]);

  @override
  String toString() {
    return "Get list inventories";
  }
}

class GetInventoriesPosm extends InventoriesEvent {
  final DateTime starDay;
  final DateTime endDay;
  final int value;

  GetInventoriesPosm({this.starDay, this.endDay, this.value}) : super([starDay, endDay, value]);

  @override
  String toString() {
    return "Get list inventories";
  }
}

