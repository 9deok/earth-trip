import 'package:flutter/material.dart';

class PlanCardStyles {
  static const titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const dDayStyle = TextStyle(
    color: Colors.green,
  );

  static BoxDecoration cardDecoration(BuildContext context) => BoxDecoration(
        border: Border.all(color: Colors.green.shade100),
        borderRadius: BorderRadius.circular(8),
      );
}