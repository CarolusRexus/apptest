import 'package:apptest/application/ui/widgets/app_card.dart';
import 'package:apptest/application/utils/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/navigation/navigation_cubit.dart';
import '../choice/choice_background.dart';
import '../date_of_birth/date_of_birth_background.dart';
import '../error/error.dart';

class Summary extends StatelessWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavigationCubit>();
    final state = cubit.state;
    if (state is SummaryState) {
      return Scaffold(
        body: Stack(
          children: [
            const ChoiceBackground(),
            const DateOfBirthBackground(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 4,
                    child: Container(),
                  ),
                  Text(
                    state.year.toString(),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  AppCard(title: state.choice.toText),
                  Flexible(
                    flex: 6,
                    child: Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return const ErrorPage();
    }
  }
}
