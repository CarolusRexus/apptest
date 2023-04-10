part of 'navigation_cubit.dart';

enum Choice { pregnancy, period }


///each class describes the state of current page
@immutable
abstract class NavigationState {}

class ChoiceState extends NavigationState {
  ChoiceState();
}

class DateOfBirthState extends ChoiceState {
  final Choice choice;

  DateOfBirthState(this.choice);
}

class SummaryState extends DateOfBirthState {
  final int year;

  SummaryState(this.year, super.choice);
}
