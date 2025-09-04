import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/spacing.dart';

class PlanCardStyles {
  static const titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const dDayStyle = TextStyle();

  static const EdgeInsets cardMargin = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.sm,
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(AppSpacing.md);

  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x14000000), blurRadius: 20, offset: Offset(0, 8)),
  ];

  static BoxDecoration cardDecoration(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      border: Border.all(color: scheme.outlineVariant),
      borderRadius: BorderRadius.circular(AppRadii.lg),
      boxShadow: cardShadow,
      color: scheme.surface,
    );
  }
}
