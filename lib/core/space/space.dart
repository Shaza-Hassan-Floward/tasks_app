import 'package:flutter/material.dart';

import 'app_space.dart';

class Space {
  static const hXs = SizedBox(height: AppSpacing.xs);
  static const hSm = SizedBox(height: AppSpacing.sm);
  static const hMd = SizedBox(height: AppSpacing.md);
  static const hLg = SizedBox(height: AppSpacing.lg);
  static const hXl = SizedBox(height: AppSpacing.xl);

  static const wXs = SizedBox(width: AppSpacing.xs);
  static const wSm = SizedBox(width: AppSpacing.sm);
  static const wMd = SizedBox(width: AppSpacing.md);
  static const wLg = SizedBox(width: AppSpacing.lg);
  static const wXl = SizedBox(width: AppSpacing.xl);

  static Widget customHeight(double height) {
    return SizedBox(height: height);
  }

  static Widget customWidth(double width) {
    return SizedBox(width: width);
  }

  static const allXs = SizedBox(height: AppSpacing.xs, width: AppSpacing.xs);
  static const allSm = SizedBox(height: AppSpacing.sm, width: AppSpacing.sm);
  static const allMd = SizedBox(height: AppSpacing.md, width: AppSpacing.md);
  static const allLg = SizedBox(height: AppSpacing.lg, width: AppSpacing.lg);
  static const allXl = SizedBox(height: AppSpacing.xl, width: AppSpacing.xl);
}
