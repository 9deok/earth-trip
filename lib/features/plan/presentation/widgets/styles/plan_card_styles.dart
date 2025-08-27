import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/spacing.dart';

class PlanCardStyles {
  static const titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const dDayStyle = TextStyle(color: AppColors.primary);

  static BoxDecoration cardDecoration(BuildContext context) => BoxDecoration(
    border: Border.all(color: AppColors.primary.shade100),
    borderRadius: BorderRadius.circular(AppRadii.md),
  );
}
