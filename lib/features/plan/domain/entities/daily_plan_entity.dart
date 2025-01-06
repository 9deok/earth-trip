import 'package:flutter/foundation.dart';

class DailyPlanEntity {
  final String id;
  final DateTime date;
  final String summary;
  final String imageUrl;
  final List<String> places;
  final int mealCount;
  final int moveCount;

  const DailyPlanEntity({
    required this.id,
    required this.date,
    required this.summary,
    required this.imageUrl,
    required this.places,
    required this.mealCount,
    required this.moveCount,
  });
}
