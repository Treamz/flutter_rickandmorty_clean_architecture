import 'dart:core';

import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:app/feature/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SearchPerson extends UseCase<List<PersonEntity>,SearchPersonParams>{
  final PersonRepository personRepository;
  SearchPerson(this.personRepository);

  Future<Either<Failure,List<PersonEntity>>> call(SearchPersonParams params) async {
    return await personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;
  SearchPersonParams({required this.query});

  @override
  // TODO: implement props
  List<Object?> get props => [query];

}