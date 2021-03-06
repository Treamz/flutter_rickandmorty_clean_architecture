import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PersonSearchState extends Equatable {
  PersonSearchState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonEmpty extends PersonSearchState {}

class PersonSearchLoading extends PersonSearchState {}

class PersonSearchLoaded extends PersonSearchState {
  final List<PersonEntity> persons;
  PersonSearchLoaded({required this.persons});

  @override
  List<Object?> get props => [persons];
}

class PersonSearchError extends PersonSearchState {
  final String message;
  PersonSearchError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}