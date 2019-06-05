import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class SynchronizationState extends Equatable {
  final bool isSynchronized;
  final bool isSynchronizing;
  final int process;
  final int total;

  SynchronizationState({
    @required this.isSynchronized,
    this.isSynchronizing: false,
    this.process: 0,
    this.total: 0,
  }) : super([isSynchronized, isSynchronizing, process, total]);

  factory SynchronizationState.notSynchronized(int total) =>
      SynchronizationState(
        isSynchronized: false,
        total: total,
      );

  factory SynchronizationState.synchronizing(int process, int total) =>
      SynchronizationState(
        isSynchronized: true,
        isSynchronizing: true,
        process: process,
        total: total,
      );

  factory SynchronizationState.synchronized() =>
      SynchronizationState(isSynchronized: true);
}
