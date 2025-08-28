import 'package:flutter/material.dart';
import 'styles/plan_card_styles.dart';
import 'plan_card_header.dart';
import 'plan_card_date_range.dart';
import 'plan_card_info_row.dart';
import 'plan_card_likes_and_participants.dart';
import '../pages/plan_detail_page.dart';

/// 여행 정보를 카드 형태로 렌더링하는 UI 컴포넌트
class PlanCard extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final int daysLeft;
  final String flightDuration;
  final String stayDuration;
  final int cost;
  final int likes;
  final int participants;

  const PlanCard({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.daysLeft,
    required this.flightDuration,
    required this.stayDuration,
    required this.cost,
    required this.likes,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PlanDetailPage(
                  planId: id,
                  title: title,
                  country: '스페인', // 실제로는 데이터에서 가져와야 합니다
                  city: '바르셀로나', // 실제로는 데이터에서 가져와야 합니다
                  startDate: startDate,
                  endDate: endDate,
                ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: PlanCardStyles.cardDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlanCardHeader(
              flagAsset: imageUrl,
              title: title,
              daysLeft: daysLeft,
            ),
            const SizedBox(height: 4),
            PlanCardDateRange(startDate: startDate, endDate: endDate),
            const SizedBox(height: 8),
            PlanCardInfoRow(
              flightDuration: flightDuration,
              stayDuration: stayDuration,
              cost: cost,
            ),
            const SizedBox(height: 8),
            PlanCardLikesAndParticipants(
              likes: likes,
              participants: participants,
            ),
          ],
        ),
      ),
    );
  }
}
