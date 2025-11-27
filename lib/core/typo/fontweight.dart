import 'package:flutter/material.dart';

enum AppFontWeight {
  regular(FontWeight.w400),
  medium(FontWeight.w500),
  semiBold(FontWeight.w600),
  bold(FontWeight.w700);

  const AppFontWeight(this.value);

  final FontWeight value;
}
