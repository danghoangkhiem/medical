import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:medical/src/models/schedule_coaching_model.dart';

class ScheduleCoachingState extends Equatable {
  final bool isInitialized;
  final bool isInitializing;
  final bool isLoading;
  final bool hasFailed;
  final DateTime daySelected;
  final String errorMessage;
  final ScheduleCoachingListModel schedules;

  ScheduleCoachingState({
    @required this.isInitialized,
    this.isInitializing = false,
    this.isLoading = false,
    this.hasFailed = false,
    this.daySelected,
    this.errorMessage,
    this.schedules,
  }) : super([
          isInitialized,
          isInitializing,
          isLoading,
          hasFailed,
          daySelected,
          errorMessage,
          schedules,
        ]);

  factory ScheduleCoachingState.uninitialized() => ScheduleCoachingState(
        isInitialized: false,
      );

  factory ScheduleCoachingState.initialized() => ScheduleCoachingState(
        isInitialized: true,
      );

  factory ScheduleCoachingState.loading() => ScheduleCoachingState(
        isInitialized: true,
        isLoading: true,
      );

  factory ScheduleCoachingState.loaded({
    @required ScheduleCoachingListModel schedules,
  }) =>
      ScheduleCoachingState(
        isInitialized: true,
        isLoading: false,
        schedules: schedules,
      );

  factory ScheduleCoachingState.selectedDay({
    @required DateTime day,
    @required ScheduleCoachingListModel schedules,
  }) =>
      ScheduleCoachingState(
        isInitialized: true,
        daySelected: day,
        schedules: schedules,
      );

  factory ScheduleCoachingState.failure({
    @required String errorMessage,
    @required bool isInitialized,
  }) =>
      ScheduleCoachingState(
        isInitialized: isInitialized,
        hasFailed: true,
        errorMessage: errorMessage?.toString(),
      );
}
