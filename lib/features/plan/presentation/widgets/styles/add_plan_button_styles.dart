import 'package:flutter/material.dart';

class AddPlanButtonStyles {
  static const double buttonHeight = 40;
  static const double iconSize = 18;
  static const TextStyle labelTextStyle = TextStyle(fontSize: 14);

  static ButtonStyle buttonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      minimumSize: const Size(0, buttonHeight),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: 4,
    );
  }
}
