import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/font_family.dart';

abstract class AppTheme {
  static final  light = ThemeData(
    fontFamily: FontFamily.nunito,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
  );
}
