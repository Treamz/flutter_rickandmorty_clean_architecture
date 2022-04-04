import 'package:app/core/error/exception.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/platform/network_info.dart';
import 'package:app/feature/data/datasources/person_local_data_source.dart';
import 'package:app/feature/data/datasources/person_remote_data_source.dart';
import 'package:app/feature/data/models/person_model.dart';
import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:app/feature/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class PersonRepositryEmpl implements PersonRepository {
  final PersonRemoteDataSource personRemoteDataSource;
  final PersonLocalDataSource personLocalDataSource;
  final NetworkInfo networkInfo;

  PersonRepositryEmpl(
      {required this.personRemoteDataSource,
      required this.personLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async{
    // TODO: implement getAllPersons
   return await _getPersons(() => personRemoteDataSource.getAllPersons(page));
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async{
    // TODO: implement searchPerson
    return await _getPersons(() => personRemoteDataSource.searchPerson(query));
  }

  Future<Either<Failure,List<PersonModel>>> _getPersons(Future<List<PersonModel>> Function() getPersons) async{
    if(await networkInfo.isConnected) {

      try {
        final remotePerson = await getPersons();
        personLocalDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      }
      catch(ex) {
        return Left(ServerFailure());
      }
    }
    else {
      try {
        final locationPerson = await personLocalDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      }
      on CacheException {
        return Left(CacheFailure());
      }
    }

  }
}
