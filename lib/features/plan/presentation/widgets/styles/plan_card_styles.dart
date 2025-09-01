import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/spacing.dart';

class PlanCardStyles {
  static const titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const dDayStyle = TextStyle(color: AppColors.primary);

  static const EdgeInsets cardMargin = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.sm,
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(AppSpacing.md);

  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
  ];

  static BoxDecoration cardDecoration(BuildContext context) => BoxDecoration(
    border: Border.all(color: AppColors.primary.shade100),
    borderRadius: BorderRadius.circular(AppRadii.md),
    boxShadow: cardShadow,
    color: Colors.white,
  );
}
