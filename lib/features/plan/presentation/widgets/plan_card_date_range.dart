import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanCardDateRange extends StatelessWidget {
  final DateTime startDate, endDate;
  const PlanCardDateRange({super.key, required this.startDate, required this.endDate});
  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('yyyy-MM-dd');
    return Text('${dateFmt.format(startDate)} - ${dateFmt.format(endDate)}');
  }
}