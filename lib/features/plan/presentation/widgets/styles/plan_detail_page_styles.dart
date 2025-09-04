import 'package:flutter/material.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/text_styles.dart';

class PlanDetailPageStyles {
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    vertical: AppSpacing.md,
    horizontal: AppSpacing.md,
  );

  static const BorderRadius sectionTopRadius = BorderRadius.vertical(
    top: Radius.circular(AppRadii.xl),
  );

  static const TextStyle sectionTitleStyle = AppTextStyles.titleLg;
}
