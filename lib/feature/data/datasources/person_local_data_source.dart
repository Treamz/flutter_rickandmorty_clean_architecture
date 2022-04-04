import 'dart:convert';

import 'package:app/core/error/exception.dart';
import 'package:app/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  
  Future<List<PersonModel>> getLastPersonsFromCache();

  Future<void> personsToCache(List<PersonModel> persons);
}

class PersonDataSourceImpl extends PersonLocalDataSource {

  final SharedPreferences sharedPreferences;
  PersonDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    // TODO: implement getLastPersonsFromCache
    final jsonPersonsList = sharedPreferences.getStringList('CACHED_PERSONS_LIST');
    if(jsonPersonsList != null) {
      return Future.value(jsonPersonsList.map((person) => PersonModel.fromJson(json.decode(person))).toList());
    }
    else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    // TODO: implement personsToCache
    final List jsonPersonsList = persons.map((person) => json.encode(person.toJson())).toList();
    
    sharedPreferences.setStringList("CACHED_PERSONS_LIST", jsonPersonsList as List<String>);
    print("Persons to write cache ${jsonPersonsList.length}");
    return Future.value(jsonPersonsList);
  }
  
}