import 'package:flutter/material.dart';
import '../../../../../core/theme/spacing.dart';

class DiaryTripCardStyles {
  static const double imageHeight = 200;
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.md,
  );

  static const EdgeInsets badgePadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.sm,
    vertical: AppSpacing.xs,
  );

  static const EdgeInsets previewPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
  );

  static const TextStyle badgeTextStyle = TextStyle(color: Colors.white);

  static BoxDecoration overlayBadgeDecoration(BuildContext context) =>
      BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(AppRadii.md),
      );

  static TextStyle headerTitleStyle(BuildContext context) =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle headerMetaStyle = TextStyle(color: Colors.black54);

  static const double indicatorDotSizeActive = 10;
  static const double indicatorDotSize = 6;
  static const EdgeInsets indicatorMargin = EdgeInsets.symmetric(
    horizontal: 3,
    vertical: AppSpacing.sm,
  );
}
