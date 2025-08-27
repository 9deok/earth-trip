import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/spacing.dart';

class AddPlanButtonStyles {
  static const double buttonHeight = 40;
  static const double iconSize = 18;
  static const TextStyle labelTextStyle = TextStyle(fontSize: 14);

  static ButtonStyle buttonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      minimumSize: const Size(0, buttonHeight),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: 4,
    );
  }
}
