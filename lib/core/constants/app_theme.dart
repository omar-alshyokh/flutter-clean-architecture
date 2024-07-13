import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

final ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle:
        SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.white),
    colorScheme:
    ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor));

final ThemeData themeDataDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  colorScheme:
  ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
);
