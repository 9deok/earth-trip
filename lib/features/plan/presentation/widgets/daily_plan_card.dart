import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/daily_plan_entity.dart';

class DailyPlanCard extends StatelessWidget {
  final DailyPlanEntity dailyPlan;
  final int dayNumber;
  final VoidCallback onTap;

  const DailyPlanCard({
    super.key,
    required this.dailyPlan,
    required this.dayNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy.MM.dd (E)', 'ko_KR');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 대표 이미지
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                dailyPlan.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 날짜 정보
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'DAY $dayNumber',
                          style: TextStyle(
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        dateFormat.format(dailyPlan.date),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // 한줄 요약
                  Text(
                    dailyPlan.summary,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // 방문 장소 수, 식사 수, 이동 수
                  Row(
                    children: [
                      const Icon(Icons.place, size: 16, color: Colors.red),
                      const SizedBox(width: 4),
                      Text('장소 ${dailyPlan.places.length}곳'),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.restaurant,
                        size: 16,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text('식사 ${dailyPlan.mealCount}회'),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.directions_walk,
                        size: 16,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 4),
                      Text('이동 ${dailyPlan.moveCount}회'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // 상세보기 버튼
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: onTap,
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: const Text('상세보기'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green,
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
