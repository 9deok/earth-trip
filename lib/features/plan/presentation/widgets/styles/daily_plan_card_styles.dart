import 'package:flutter/material.dart';

class DailyPlanCardStyles {
  static const double imageHeight = 120;

  static EdgeInsetsGeometry cardMargin = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
  static EdgeInsetsGeometry contentPadding = const EdgeInsets.all(12);

  static RoundedRectangleBorder cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  );
  static BorderRadius imageTopRadius = const BorderRadius.vertical(
    top: Radius.circular(12),
  );

  static BoxDecoration dayBadgeDecoration(BuildContext context) =>
      BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(4),
      );

  static TextStyle dayBadgeTextStyle(BuildContext context) =>
      TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold);

  static CalendarStyles calendarStyles(BuildContext context) =>
      CalendarStyles();
}

class CalendarStyles {}
