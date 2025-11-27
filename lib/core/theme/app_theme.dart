import 'package:flutter/material.dart';
import 'package:tasks_app/core/typo/typography.dart';

import '../color/color.dart';

ThemeData lightAppTheme() {
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primary, brightness: Brightness.light),
      textTheme: AppTypography.lightTextTheme);
}

ThemeData darkAppTheme() {
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primary, brightness: Brightness.dark),
      textTheme: AppTypography.darkTextTheme);
}
