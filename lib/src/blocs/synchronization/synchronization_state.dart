import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class SynchronizationState extends Equatable {
  final bool isSynchronized;
  final bool isSynchronizing;
  final bool isDownloading;
  final bool isUploading;
  final int downloaded;
  final int uploaded;
  final int total;

  SynchronizationState({
    @required this.isSynchronized,
    this.isSynchronizing: false,
    this.isDownloading: false,
    this.isUploading: false,
    this.downloaded: 0,
    this.uploaded: 0,
    this.total: 0,
  }) : super([
          isSynchronized,
          isSynchronizing,
          isDownloading,
          isUploading,
          downloaded,
          uploaded,
          total,
        ]);

  factory SynchronizationState.notSynchronized(int total) =>
      SynchronizationState(
        isSynchronized: false,
        total: total,
      );

  factory SynchronizationState.synchronizing() => SynchronizationState(
        isSynchronized: false,
        isSynchronizing: true,
        isDownloading: true,
        isUploading: true,
      );

  factory SynchronizationState.downloading(int downloaded) =>
      SynchronizationState(
        isSynchronized: false,
        isSynchronizing: true,
        isDownloading: true,
        downloaded: downloaded,
      );

  factory SynchronizationState.uploading(int uploaded, int total) =>
      SynchronizationState(
        isSynchronized: false,
        isSynchronizing: true,
        isUploading: true,
        uploaded: uploaded,
        total: total,
      );

  factory SynchronizationState.synchronized({
    int downloaded = 0,
    int uploaded = 0,
    int total = 0,
  }) =>
      SynchronizationState(
        isSynchronized: true,
        downloaded: downloaded,
        uploaded: uploaded,
        total: total,
      );
}
