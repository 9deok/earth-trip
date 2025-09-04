import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/daily_plan_entity.dart';
import 'styles/daily_plan_card_styles.dart';
import '../../../../core/i18n/strings.dart';
import '../../../../core/widgets/adaptive_image.dart';

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
      margin: DailyPlanCardStyles.cardMargin,
      elevation: 0,
      shape: DailyPlanCardStyles.cardShape,
      child: InkWell(
        onTap: onTap,
        borderRadius:
            DailyPlanCardStyles.cardShape.borderRadius as BorderRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 대표 이미지
            ClipRRect(
              borderRadius: DailyPlanCardStyles.imageTopRadius,
              child: AdaptiveImage(
                urlOrPath: dailyPlan.imageUrl,
                height: DailyPlanCardStyles.imageHeight,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: DailyPlanCardStyles.contentPadding,
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
                        decoration: DailyPlanCardStyles.dayBadgeDecoration(
                          context,
                        ),
                        child: Text(
                          'DAY $dayNumber',
                          style: DailyPlanCardStyles.dayBadgeTextStyle(context),
                        ),
                      ),
                      DailyPlanCardStyles.gapSm,
                      Text(
                        dateFormat.format(dailyPlan.date),
                        style: DailyPlanCardStyles.dateTextStyle,
                      ),
                    ],
                  ),
                  DailyPlanCardStyles.gapVSm,
                  // 한줄 요약
                  Text(
                    dailyPlan.summary,
                    style: DailyPlanCardStyles.summaryTextStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  DailyPlanCardStyles.gapVMd,
                  // 방문 장소 수, 식사 수, 이동 수
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        size: 16,
                        color: DailyPlanCardStyles.iconPlace,
                      ),
                      DailyPlanCardStyles.gapXs,
                      Text(
                        '장소 ${dailyPlan.places.length}곳',
                        style: DailyPlanCardStyles.metaCountTextStyle,
                      ),
                      DailyPlanCardStyles.gapMd,
                      Icon(
                        Icons.restaurant,
                        size: 16,
                        color: DailyPlanCardStyles.iconMeal,
                      ),
                      DailyPlanCardStyles.gapXs,
                      Text(
                        '식사 ${dailyPlan.mealCount}회',
                        style: DailyPlanCardStyles.metaCountTextStyle,
                      ),
                      DailyPlanCardStyles.gapMd,
                      Icon(
                        Icons.directions_walk,
                        size: 16,
                        color: DailyPlanCardStyles.iconMove,
                      ),
                      DailyPlanCardStyles.gapXs,
                      Text(
                        '이동 ${dailyPlan.moveCount}회',
                        style: DailyPlanCardStyles.metaCountTextStyle,
                      ),
                    ],
                  ),
                  DailyPlanCardStyles.gapVSm,
                  // 상세보기 버튼
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: onTap,
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: Text(Strings.Common.details),
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
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
