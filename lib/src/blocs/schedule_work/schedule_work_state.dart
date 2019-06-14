import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:medical/src/models/schedule_work_model.dart';

class ScheduleWorkState extends Equatable {
  final bool isInitialized;
  final bool isInitializing;
  final bool isLoading;
  final DateTime daySelected;
  final String errorMessage;
  final ScheduleWorkListModel schedules;

  ScheduleWorkState({
    @required this.isInitialized,
    this.isInitializing = false,
    this.isLoading = false,
    this.daySelected,
    this.errorMessage,
    this.schedules,
  }) : super([
          isInitialized,
          isInitializing,
          isLoading,
          daySelected,
          errorMessage,
          schedules,
        ]);

  factory ScheduleWorkState.uninitialized() => ScheduleWorkState(
        isInitialized: false,
      );

  factory ScheduleWorkState.initialized() => ScheduleWorkState(
        isInitialized: true,
      );

  factory ScheduleWorkState.loading() => ScheduleWorkState(
        isInitialized: true,
        isLoading: true,
      );

  factory ScheduleWorkState.loaded({
    @required ScheduleWorkListModel schedules,
  }) =>
      ScheduleWorkState(
        isInitialized: true,
        isLoading: false,
        schedules: schedules,
      );

  factory ScheduleWorkState.selectedDay({
    @required DateTime day,
    @required ScheduleWorkListModel schedules,
  }) =>
      ScheduleWorkState(
        isInitialized: true,
        daySelected: day,
        schedules: schedules,
      );

  factory ScheduleWorkState.failure({
    @required String errorMessage,
    @required bool isInitialized,
  }) =>
      ScheduleWorkState(
        isInitialized: isInitialized,
        errorMessage: errorMessage?.toString(),
      );
}
