import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MedRepEvent extends Equatable {
  MedRepEvent([List props = const []]) : super(props);
}

class GetMedRep extends MedRepEvent {
  final int offset;
  final int limit;

  GetMedRep({
    this.offset = 0,
    this.limit = 10,
  }) : super([offset, limit]);

}

class LoadMore extends MedRepEvent {}

