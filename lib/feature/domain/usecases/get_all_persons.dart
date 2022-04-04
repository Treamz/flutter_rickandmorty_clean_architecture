import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:app/feature/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepository;
  GetAllPersons(this.personRepository);

  Future<Either<Failure,List<PersonEntity>>> call(PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}
class PagePersonParams extends Equatable {
  final int page;
  PagePersonParams({required this.page});
  @override
  // TODO: implement props
  List<Object?> get props => [page];
}