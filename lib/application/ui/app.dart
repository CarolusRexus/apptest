import 'package:apptest/application/ui/navigation/navigation_listener.dart';
import 'package:apptest/application/ui/screens/choice/choise.dart';
import 'package:apptest/application/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

import '../blocs/navigation/navigation_cubit.dart';
import 'navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({super.key});

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: NavigationListener(
        navigatorKey: _navigatorKey,
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          theme: AppTheme.light,
          routes: Routes.routes,
          initialRoute: Routes.choice,
        ),
      ),
    );
  }
}
