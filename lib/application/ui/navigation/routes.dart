import 'package:apptest/application/ui/screens/choice/choise.dart';
import 'package:apptest/application/ui/screens/date_of_birth/date_of_birth.dart';
import 'package:flutter/cupertino.dart';

import '../screens/summary/summary.dart';

class Routes {
  Routes._();

  //static variables
  static const String choice = '/choice';
  static const String dateOfBirth = '/date_of_birth';
  static const String summary = '/summary';


  static final routes = <String, WidgetBuilder>{
    choice: (BuildContext context) => const ChoicePage(),
    dateOfBirth: (BuildContext context) => const DateOfBirthPage(),
    summary: (BuildContext context) => const Summary(),
  };
}
