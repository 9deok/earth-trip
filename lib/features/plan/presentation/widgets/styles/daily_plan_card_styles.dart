import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/spacing.dart';

class DailyPlanCardStyles {
  static const double imageHeight = 120;

  static EdgeInsetsGeometry cardMargin = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
  static EdgeInsetsGeometry contentPadding = const EdgeInsets.all(12);

  static RoundedRectangleBorder cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppRadii.lg),
  );
  static BorderRadius imageTopRadius = BorderRadius.vertical(
    top: Radius.circular(AppRadii.lg),
  );

  static BoxDecoration dayBadgeDecoration(BuildContext context) =>
      BoxDecoration(
        color: AppColors.primary.shade100,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      );

  static TextStyle dayBadgeTextStyle(BuildContext context) =>
      TextStyle(color: AppColors.primary.shade800, fontWeight: FontWeight.bold);

  static CalendarStyles calendarStyles(BuildContext context) =>
      CalendarStyles();
}

class CalendarStyles {}
