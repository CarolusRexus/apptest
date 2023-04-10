import 'package:apptest/application/ui/screens/choice/choise.dart';
import 'package:apptest/application/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

import '../blocs/navigation/navigation_cubit.dart';
import 'navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: MaterialApp(
        theme: AppTheme.light,
        routes: Routes.routes,
        home: BlocListener<NavigationCubit, NavigationState>(
          listener: (context, state) {
            if (state is SummaryState) {
              Navigator.of(context).pushNamed(Routes.summary);
            } else if (state is DateOfBirthState) {
              Navigator.of(context).pushNamed(Routes.dateOfBirth);
            }
          },
          child: const ChoicePage(),
        ),
      ),
    );
  }
}
