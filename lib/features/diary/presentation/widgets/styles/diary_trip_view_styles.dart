import 'package:flutter/material.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/colors.dart';

class DiaryTripViewStyles {
  static const TextStyle headerTitleStyle = AppTextStyles.titleLg;
  static const TextStyle headerMetaStyle = AppTextStyles.bodyMuted;

  static const List<BoxShadow> imageShadow = [
    BoxShadow(color: Color(0x14000000), blurRadius: 20, offset: Offset(0, 8)),
  ];

  static BorderRadius imageBorderRadius = BorderRadius.circular(AppRadii.lg);

  static const EdgeInsets pagePadding = EdgeInsets.all(AppSpacing.md);

  static BoxDecoration imageGradientOverlay(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          scheme.scrim.withValues(alpha: 0.2),
          scheme.scrim.withValues(alpha: 0.45),
        ],
      ),
    );
  }

  static Color moodBackgroundColor(BuildContext context, int mood) {
    final scheme = Theme.of(context).colorScheme;
    switch (mood) {
      case 1:
        return scheme.errorContainer;
      case 2:
        return scheme.secondaryContainer;
      case 3:
        return scheme.primaryContainer;
      case 4:
        return scheme.tertiaryContainer;
      case 5:
      default:
        return scheme.primary;
    }
  }

  static Color moodTextColor(BuildContext context, int mood) {
    final scheme = Theme.of(context).colorScheme;
    switch (mood) {
      case 1:
        return scheme.onErrorContainer;
      case 2:
        return scheme.onSecondaryContainer;
      case 3:
        return scheme.onPrimaryContainer;
      case 4:
        return scheme.onTertiaryContainer;
      case 5:
      default:
        return scheme.onPrimary;
    }
  }
}
