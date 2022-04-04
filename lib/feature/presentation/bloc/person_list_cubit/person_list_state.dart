import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PersonState extends Equatable {
  PersonState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
@override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  final List<PersonEntity> oldPersonList;
  final bool isFirstFetch;
  PersonLoading({this.isFirstFetch = false, required this.oldPersonList});

  @override
  // TODO: implement props
  List<Object?> get props => [oldPersonList];
}

class PersonLoaded extends PersonState {
  final List<PersonEntity> personsList;
  PersonLoaded({required this.personsList});
  @override
  // TODO: implement props
  List<Object?> get props => [personsList];
}

class PersonError extends PersonState {
  final String message;
  PersonError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}