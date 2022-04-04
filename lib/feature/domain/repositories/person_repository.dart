import 'package:app/core/error/failure.dart';
import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PersonRepository {
  Future<Either<Failure,List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure,List<PersonEntity>>> searchPerson(String query);
}