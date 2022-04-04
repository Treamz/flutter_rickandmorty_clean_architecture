import 'package:app/core/error/failure.dart';
import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:app/feature/domain/usecases/get_all_persons.dart';
import 'package:app/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;
  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());
  int page = 1;
  void loadPerson() async{
    if(state is PersonLoading) return;

    final currentState = state;
    var oldPerson = <PersonEntity>[];
    if(currentState is PersonLoaded) {
      oldPerson = currentState.personsList;
    }
    emit(PersonLoading(oldPersonList: oldPerson,isFirstFetch: page == 1));

    final failurOrPerson = await getAllPersons(PagePersonParams(page: page));
    print(failurOrPerson);
    failurOrPerson.fold((error) => emit(PersonError(message: failureMessage(error))), (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonList;
      persons.addAll(character);
      emit(PersonLoaded(personsList: persons));
    });
  }

  String failureMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default: {
        return 'Unexpected Failure';
      }
    }
  }


}