import 'package:flutter/material.dart';
import 'styles/plan_card_styles.dart';
import 'styles/plan_card_header_styles.dart';

class PlanCardHeader extends StatelessWidget {
  final String flagAsset, title;
  final int daysLeft;
  const PlanCardHeader({
    super.key,
    required this.flagAsset,
    required this.title,
    required this.daysLeft,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      ClipRRect(
        borderRadius: PlanCardHeaderStyles.flagRadius,
        child: Image.asset(
          (flagAsset.isEmpty) ? 'assets/flags/default.png' : flagAsset,
          width: PlanCardHeaderStyles.flagWidth,
          height: PlanCardHeaderStyles.flagHeight,
          fit: BoxFit.cover,
        ),
      ),
      PlanCardHeaderStyles.gapSmall,
      Expanded(
        child: Text(
          title,
          style: PlanCardStyles.titleStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const Spacer(),
      Text('D-$daysLeft', style: PlanCardStyles.dDayStyle),
    ],
  );
}
