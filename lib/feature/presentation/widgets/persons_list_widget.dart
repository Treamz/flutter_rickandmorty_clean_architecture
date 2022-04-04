import 'dart:async';

import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:app/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:app/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:app/feature/presentation/widgets/person_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsList extends StatelessWidget {
  // const PersonsList({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          // BlocProvider.of<PersonListCubit>(context)..loadPerson();
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<PersonListCubit, PersonState>(
        builder: (BuildContext context, state) {
      List<PersonEntity> persons = [];
      bool isLoading = false;
      if (state is PersonLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is PersonLoading) {
        persons = state.oldPersonList;
        isLoading = true;
      } else if (state is PersonLoaded) {
        persons = state.personsList;
      } else if (state is PersonError) {
        return Text(
          state.message,
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCard(person: persons[index]);
            } else {
              Timer(Duration(milliseconds: 30),() {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade400,
              ),
          itemCount: persons.length + (isLoading ? 1 : 0));
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
