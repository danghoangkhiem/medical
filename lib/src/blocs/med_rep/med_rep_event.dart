import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MedRepEvent extends Equatable {
  MedRepEvent([List props = const []]) : super(props);
}

class GetMedRep extends MedRepEvent {
  final int offset;
  final int limit;
  final int idMedSup;


  GetMedRep({
    this.offset = 0,
    this.limit = 10,
    @required this.idMedSup,

  }) : super([offset, limit, idMedSup]);

}

class LoadMore extends MedRepEvent {}

