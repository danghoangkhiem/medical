import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class SynchronizationState extends Equatable {
  final bool isSynchronized;
  final bool isSynchronizing;
  final int quantity;

  SynchronizationState({
    @required this.isSynchronized,
    this.isSynchronizing: false,
    this.quantity: 0,
  }) : super([isSynchronized, isSynchronizing, quantity]);

  factory SynchronizationState.notSynchronized(int quantity) =>
      SynchronizationState(
        isSynchronized: false,
        quantity: quantity,
      );

  factory SynchronizationState.synchronizing(int quantity) =>
      SynchronizationState(
        isSynchronized: true,
        isSynchronizing: true,
        quantity: quantity,
      );

  factory SynchronizationState.synchronized() =>
      SynchronizationState(isSynchronized: true);
}