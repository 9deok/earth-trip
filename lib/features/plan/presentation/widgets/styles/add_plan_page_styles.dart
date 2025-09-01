import 'package:flutter/material.dart';
import '../../../../../core/theme/spacing.dart';

class AddPlanPageStyles {
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
    vertical: AppSpacing.lg,
  );

  static EdgeInsets bottomButtonPadding(BuildContext context) =>
      EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
        top: AppSpacing.sm,
      );
}
