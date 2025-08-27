import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'styles/plan_card_info_row_styles.dart';

class PlanCardInfoRow extends StatelessWidget {
  final String flightDuration, stayDuration;
  final int cost;
  const PlanCardInfoRow({
    super.key,
    required this.flightDuration,
    required this.stayDuration,
    required this.cost,
  });
  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(Icons.flight_takeoff, size: PlanCardInfoRowStyles.iconSize),
      PlanCardInfoRowStyles.gapXs,
      Expanded(child: Text(flightDuration, overflow: TextOverflow.ellipsis)),
      PlanCardInfoRowStyles.gapSm,
      const Icon(Icons.hotel, size: PlanCardInfoRowStyles.iconSize),
      PlanCardInfoRowStyles.gapXs,
      Expanded(child: Text(stayDuration, overflow: TextOverflow.ellipsis)),
      const Spacer(),
      const Icon(Icons.attach_money, size: PlanCardInfoRowStyles.iconSize),
      PlanCardInfoRowStyles.gapXs,
      Text(NumberFormat.currency(locale: 'ko_KR', symbol: '₩').format(cost)),
    ],
  );
}
