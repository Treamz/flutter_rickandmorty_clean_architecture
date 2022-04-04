import 'package:app/common/app_colors.dart';
import 'package:app/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:app/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:app/feature/presentation/pages/person_screen.dart';
import 'package:app/locator_service.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locator_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListCubit>(
              create: (context) => sl<PersonListCubit>()..loadPerson()),
          BlocProvider<PersonSearchBloc>(
              create: (context) => sl<PersonSearchBloc>()),
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
              backgroundColor: AppColors.mainBackground,
              scaffoldBackgroundColor:AppColors.mainBackground),
          home: HomePage(),
        ));
  }
}
