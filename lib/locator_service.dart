import 'package:app/core/platform/network_info.dart';
import 'package:app/feature/data/datasources/person_local_data_source.dart';
import 'package:app/feature/data/datasources/person_remote_data_source.dart';
import 'package:app/feature/data/repositories/person_repository_impl.dart';
import 'package:app/feature/domain/repositories/person_repository.dart';
import 'package:app/feature/domain/usecases/get_all_persons.dart';
import 'package:app/feature/domain/usecases/search_person.dart';
import 'package:app/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:app/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
final sl = GetIt.instance;

Future<void> init() async {
  // bloc cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPersons: sl()));

  //use cases
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));

  // repos
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositryEmpl(
      personRemoteDataSource: sl(),
      personLocalDataSource: sl(),
      networkInfo: sl()));
  
  sl.registerLazySingleton<PersonRemoteDataSource>(() => PersonRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<PersonLocalDataSource>(() => PersonDataSourceImpl(sharedPreferences: sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}
