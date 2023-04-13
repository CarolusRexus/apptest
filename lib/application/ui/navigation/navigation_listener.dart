import 'package:apptest/application/ui/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/navigation/navigation_cubit.dart';

class NavigationListener extends StatelessWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const NavigationListener(
      {Key? key, required this.child, required this.navigatorKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listener: (_, state) {
        final context = navigatorKey.currentContext;
        if (context != null) {
          _resolveState(state, context);
        }
      },
      child: child,
    );
  }

  void _resolveState(NavigationState state, BuildContext context) {
    if (state is SummaryState) {
      Navigator.of(context).pushNamed(Routes.summary);
    } else if (state is DateOfBirthState) {
      Navigator.of(context).pushNamed(Routes.dateOfBirth);
    } else if (state is ChoiceState) {
      Navigator.of(context).pushNamed(Routes.choice);
    }
  }
}
