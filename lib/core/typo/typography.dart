import 'package:flutter/material.dart';

import '../color/color.dart';
import 'fontsize.dart';
import 'fontweight.dart';

class AppTypography {
  static const String fontFamily = 'Inter';

  // ---------- Light Mode ----------
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.display.toDouble(),
      fontWeight: AppFontWeight.semiBold.value,
      color: AppColor.primaryText,
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.title.toDouble(),
      fontWeight: AppFontWeight.semiBold.value,
      color: AppColor.primaryText,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.subtitle.toDouble(),
      fontWeight: AppFontWeight.medium.value,
      color: AppColor.primaryText,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.body.toDouble(),
      fontWeight: AppFontWeight.regular.value,
      color: AppColor.primaryText,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.caption.toDouble(),
      fontWeight: AppFontWeight.regular.value,
      color: AppColor.secondaryText,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.label.toDouble(),
      fontWeight: AppFontWeight.regular.value,
      color: AppColor.secondaryText,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.label.toDouble(),
      fontWeight: AppFontWeight.semiBold.value,
      color: AppColor.primaryText,
    ),
  );

  // ---------- Dark Mode ----------
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.display.toDouble(),
      fontWeight: AppFontWeight.semiBold.value,
      color: AppColor.darkPrimaryText,
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.title.toDouble(),
      fontWeight: AppFontWeight.semiBold.value,
      color: AppColor.darkPrimaryText,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.subtitle.toDouble(),
      fontWeight: AppFontWeight.medium.value,
      color: AppColor.darkPrimaryText,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.body.toDouble(),
      fontWeight: AppFontWeight.regular.value,
      color: AppColor.darkPrimaryText,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.caption.toDouble(),
      fontWeight: AppFontWeight.regular.value,
      color: AppColor.darkSecondaryText,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.label.toDouble(),
      fontWeight: AppFontWeight.regular.value,
      color: AppColor.darkSecondaryText,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppFontSize.label.toDouble(),
      fontWeight: AppFontWeight.semiBold.value,
      color: AppColor.darkPrimaryText,
    ),
  );
}
