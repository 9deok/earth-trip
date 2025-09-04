import 'package:flutter/material.dart';

class DiaryTripCardSection extends StatelessWidget {
  final Widget child;
  const DiaryTripCardSection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: child,
    );
  }
}
