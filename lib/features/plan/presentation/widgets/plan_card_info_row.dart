import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanCardInfoRow extends StatelessWidget {
  final String flightDuration, stayDuration;
  final int cost;
  const PlanCardInfoRow({super.key, required this.flightDuration, required this.stayDuration, required this.cost});
  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Icon(Icons.flight_takeoff, size: 16),
          const SizedBox(width: 4),
          Text(flightDuration),
          const SizedBox(width: 16),
          const Icon(Icons.hotel, size: 16),
          const SizedBox(width: 4),
          Text(stayDuration),
          const Spacer(),
          const Icon(Icons.attach_money, size: 16),
          const SizedBox(width: 4),
          Text(NumberFormat.currency(locale: 'ko_KR', symbol: '₩').format(cost)),
        ],
      );
}