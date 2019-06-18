import 'package:medical/src/models/medrep_of_medsup_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MedRepState extends Equatable {
  MedRepState([List props = const []]) : super(props);
}

class MedRepInitial extends MedRepState {
  @override
  String toString() => 'MedRepInitial';
}

class MedRepLoading extends MedRepState {
  final bool isLoadMore;

  MedRepLoading({this.isLoadMore = false});

  @override
  String toString() => 'MedRepLoading';
}

class MedRepEmpty extends MedRepState {
}

class MedRepLoaded extends MedRepState {
  final MedRepModel medRep;

  final bool isLoadMore;

MedRepLoaded({@required this.medRep, this.isLoadMore = false}) : super([medRep, isLoadMore]);

  @override
  String toString() => 'MedRepLoaded';
}

class MedRepFailure extends MedRepState {
  final String error;

  MedRepFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'MedRepFailure { error: $error }';
}

class ReachMax extends MedRepState {}