import 'package:flutter/material.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/colors.dart';

class DateRangeSelectStepStyles {
  static const TextStyle titleStyle = AppTextStyles.titleLg;
  static const SizedBox titleSpacing = SizedBox(height: AppSpacing.md);

  static ButtonStyle buttonStyle(BuildContext context) =>
      OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      );
}
