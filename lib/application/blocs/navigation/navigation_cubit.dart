import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(ChoiceState());

  void toChoicePage() {
    emit(ChoiceState());
  }

  void toDateOfBirthPage(Choice choice) => emit(DateOfBirthState(choice));

  void toSummary(int year) {
    final state = this.state;
    if (state is DateOfBirthState) {
      emit(SummaryState(year, state.choice));
    }
  }
}
