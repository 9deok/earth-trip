import 'package:flutter/material.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';

class PlanCardHeaderStyles {
  static const double flagWidth = 40;
  static const double flagHeight = 24;
  static final BorderRadius flagRadius = BorderRadius.circular(AppRadii.sm);
  static const SizedBox gapSmall = SizedBox(width: AppSpacing.sm);

  static const TextStyle titleStyle = AppTextStyles.bodyMd;

  static const TextStyle dDayStyle = TextStyle();
}
