import 'package:flutter/material.dart';
import '../../../../../core/theme/spacing.dart';

class PlanCardHeaderStyles {
  static const double flagWidth = 40;
  static const double flagHeight = 24;
  static final BorderRadius flagRadius = BorderRadius.circular(AppRadii.sm);
  static const SizedBox gapSmall = SizedBox(width: AppSpacing.sm);

  static const TextStyle titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle dDayStyle = TextStyle(color: Colors.green);
}
