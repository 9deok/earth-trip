import 'package:flutter/material.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/text_styles.dart';

class TripSummaryHeaderStyles {
  static double headerHeight(BuildContext context) =>
      MediaQuery.of(context).size.height / 3;

  static DecorationImage backgroundImage(String imageUrl) => DecorationImage(
    image: NetworkImage(imageUrl),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      Colors.black.withValues(alpha: 0.4),
      BlendMode.darken,
    ),
  );

  static const EdgeInsets contentPadding = EdgeInsets.all(AppSpacing.md);

  static const TextStyle titleTextStyle = AppTextStyles.titleXl;

  static const TextStyle bodyTextStyle = AppTextStyles.bodyMd;
  static const TextStyle bodyMutedTextStyle = AppTextStyles.bodyMuted;
}
