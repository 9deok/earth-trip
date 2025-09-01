import 'package:flutter/material.dart';
import '../../../../../core/theme/spacing.dart';

class DiaryTripViewStyles {
  static const double headerTitleFontSize = 18;
  static const TextStyle headerTitleStyle = TextStyle(
    fontSize: headerTitleFontSize,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headerMetaStyle = TextStyle(color: Colors.black54);

  static const List<BoxShadow> imageShadow = [
    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
  ];

  static BorderRadius imageBorderRadius = BorderRadius.circular(AppRadii.lg);

  static const EdgeInsets pagePadding = EdgeInsets.all(AppSpacing.md);
}
