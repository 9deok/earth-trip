import 'package:flutter/material.dart';
import '../../../../../core/theme/spacing.dart';

class PlanListSectionStyles {
  static const EdgeInsets listPadding = EdgeInsets.symmetric(
    vertical: AppSpacing.sm,
  );

  static const String defaultFlagAsset = 'assets/flags/default.png';

  static const TextStyle emptyTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  static const EdgeInsets dismissPadding = EdgeInsets.symmetric(horizontal: 20);
  static const Color dismissBackground = Colors.red;
}
