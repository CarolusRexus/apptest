import 'package:apptest/application/blocs/navigation/navigation_cubit.dart';
import 'package:apptest/application/ui/screens/choice/choice_background.dart';
import 'package:apptest/application/ui/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChoicePage extends StatelessWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ChoiceBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 4,
                  child: Container(),
                ),
                AppCard(
                  title: 'Track my period',
                  subtitle: 'contraception and well-being',
                  onPressed: () => context
                      .read<NavigationCubit>()
                      .toDateOfBirthPage(Choice.period),
                ),
                AppCard(
                  title: 'Get pregnant',
                  subtitle: 'learn about reproductive health',
                  onPressed: () => context
                      .read<NavigationCubit>()
                      .toDateOfBirthPage(Choice.pregnancy),
                ),
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
  }
}
