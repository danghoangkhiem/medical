import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ApplicationState extends Equatable {
  final bool isInitialized;
  final bool isInitializing;
  final int progress;

  ApplicationState({
    @required this.isInitialized,
    this.isInitializing: false,
    this.progress: 0,
  }) : super([isInitialized, isInitializing, progress]);

  factory ApplicationState.uninitialized() =>
      ApplicationState(
          isInitialized: false
      );

  factory ApplicationState.progressing(int progress) =>
      ApplicationState(
          isInitialized:  100 == progress,
          isInitializing: 100 != progress,
          progress: progress
      );

  factory ApplicationState.initialized() =>
      ApplicationState(
          isInitialized: true,
          progress: 100
      );
}