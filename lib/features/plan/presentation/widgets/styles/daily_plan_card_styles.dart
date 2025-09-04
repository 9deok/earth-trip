import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/text_styles.dart';

class DailyPlanCardStyles {
  static const double imageHeight = 120;

  static const EdgeInsets cardMargin = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.sm,
  );
  static const EdgeInsets contentPadding = EdgeInsets.all(AppSpacing.md);

  static final RoundedRectangleBorder cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppRadii.lg),
  );
  static final BorderRadius imageTopRadius = BorderRadius.vertical(
    top: Radius.circular(AppRadii.lg),
  );

  static BoxDecoration dayBadgeDecoration(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: scheme.primaryContainer,
      borderRadius: BorderRadius.circular(AppRadii.sm),
    );
  }

  static TextStyle dayBadgeTextStyle(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TextStyle(
      color: scheme.onPrimaryContainer,
      fontWeight: FontWeight.bold,
    );
  }

  static const SizedBox gapXs = SizedBox(width: AppSpacing.xs);
  static const SizedBox gapSm = SizedBox(width: AppSpacing.sm);
  static const SizedBox gapMd = SizedBox(width: AppSpacing.md);
  static const SizedBox gapVSm = SizedBox(height: AppSpacing.sm);
  static const SizedBox gapVMd = SizedBox(height: AppSpacing.md);

  static const TextStyle dateTextStyle = TextStyle(
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle summaryTextStyle = AppTextStyles.bodyMd;

  static const Color iconPlace = Colors.red;
  static const Color iconMeal = Colors.orange;
  static const Color iconMove = Colors.blue;

  static const TextStyle metaCountTextStyle = AppTextStyles.bodyMd;
}

class CalendarStyles {}
