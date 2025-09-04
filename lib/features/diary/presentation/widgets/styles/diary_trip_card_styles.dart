import 'package:flutter/material.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/text_styles.dart';

class DiaryTripCardStyles {
  static const double imageHeight = 240;
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
  static const EdgeInsets imageHorizontalPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
  );

  static const TextStyle badgeTextStyle = TextStyle(color: Colors.white);

  static BoxDecoration overlayBadgeDecoration(BuildContext context) =>
      BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(AppRadii.md),
      );

  static TextStyle headerTitleStyle(BuildContext context) =>
      AppTextStyles.titleLg;

  static const TextStyle headerMetaStyle = AppTextStyles.bodyMuted;

  static const double indicatorDotSizeActive = 10;
  static const double indicatorDotSize = 6;
  static const EdgeInsets indicatorMargin = EdgeInsets.symmetric(
    horizontal: 3,
    vertical: AppSpacing.sm,
  );

  static BoxDecoration imageGradientOverlay(BuildContext context) =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.15),
            Colors.black.withValues(alpha: 0.35),
          ],
        ),
      );

  static final BorderRadius imageInnerRadius = BorderRadius.circular(
    AppRadii.lg,
  );
  static const SizedBox previewTopGap = SizedBox(height: AppSpacing.md);

  static Color indicatorColor(BuildContext context, bool active) {
    final scheme = Theme.of(context).colorScheme;
    return active
        ? scheme.primary
        : scheme.onSurfaceVariant.withValues(alpha: 0.5);
  }
}
