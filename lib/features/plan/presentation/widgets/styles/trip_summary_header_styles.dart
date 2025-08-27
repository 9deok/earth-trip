import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/spacing.dart';

class TripSummaryHeaderStyles {
  static double headerHeight(BuildContext context) =>
      MediaQuery.of(context).size.height / 3;

  static DecorationImage backgroundImage(String imageUrl) => DecorationImage(
    image: NetworkImage(imageUrl),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      Colors.black.withOpacity(0.4),
      BlendMode.darken,
    ),
  );

  static const EdgeInsets contentPadding = EdgeInsets.all(AppSpacing.md);

  static const TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyTextStyle = TextStyle(color: Colors.white);
  static const TextStyle bodyMutedTextStyle = TextStyle(color: Colors.white70);
}
