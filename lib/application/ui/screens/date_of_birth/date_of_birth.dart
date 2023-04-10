import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/navigation/navigation_cubit.dart';
import '../../../constants/colors.dart';
import '../../widgets/spinner_year_picker.dart';

import '../error/error.dart';
import 'date_of_birth_background.dart';

class DateOfBirthPage extends StatefulWidget {
  const DateOfBirthPage({Key? key}) : super(key: key);

  @override
  State<DateOfBirthPage> createState() => _DateOfBirthPageState();
}

class _DateOfBirthPageState extends State<DateOfBirthPage> {
  int year = 2000;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavigationCubit>();
    final state = cubit.state;

    if (state is DateOfBirthState) {
      return Scaffold(
        body: Stack(
          children: [
            const DateOfBirthBackground(),
            _buildDateOfBirthSelection(),
            _buildNextButton()
          ],
        ),
      );
    } else {
      return const ErrorPage();
    }
  }

  Widget _buildDateOfBirthSelection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Log in your date of birth',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 60),
          TimePickerSpinner(
            maxYear: 2020,
            minYear: 2000,
            onYearChange: (int year) => setState(() {
              this.year = year;
            }),
            itemHeight: 60,
            itemWidth: 100,
            textStyleSelector: _textTypeSelector,
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 80),
      child: Container(
        height: 50,
        width: 190,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.secondary,
              AppColors.background,
            ],
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          onTap: () => context.read<NavigationCubit>().toSummary(year),
          child: const Center(
            child: Text('Next'),
          ),
        ),
      ),
    );
  }

  TextStyle _textTypeSelector(int index, int selectedIndex, _) {
    if ((selectedIndex - index).abs() == 0) {
      return const TextStyle(
        color: AppColors.black,
        fontSize: 34,
        fontWeight: FontWeight.w900,
      );
    } else if ((selectedIndex - index).abs() == 1) {
      return const TextStyle(
        color: AppColors.gray,
        fontSize: 34,
        fontWeight: FontWeight.w900,
      );
    } else {
      return const TextStyle(
        color: AppColors.whiteSmoke,
        fontSize: 34,
        fontWeight: FontWeight.w900,
      );
    }
  }
}
