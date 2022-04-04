import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:app/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:app/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:app/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:app/feature/presentation/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters...');

  final suggestions = ['Rick', 'Morty', 'Summer', 'Beth', 'Jerry'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        tooltip: 'Back',
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    print("Inside search delegate $query");
    BlocProvider.of<PersonSearchBloc>(context, listen: false)..add(SearchPersons(query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
        builder: (BuildContext context, state) {
      if (state is PersonSearchLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PersonSearchLoaded) {
        final person = state.persons;
        if(person.isEmpty) {
          return _showErrorText('No characters found');
        }
        return Container(
          child: ListView.builder(
              itemCount: person.isNotEmpty ? person.length : 0,
              itemBuilder: (context, index) {
                PersonEntity result = person[index];
                return SearchResult(personResult: result);
              }),
        );
      } else if (state is PersonSearchError) {
        return _showErrorText(state.message);
      }
      return Icon(Icons.wallpaper);
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isNotEmpty) {
      return Text("");
    }
    return ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Text(
            suggestions[index],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: suggestions.length);
  }

  Widget _showErrorText(error) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          error,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
