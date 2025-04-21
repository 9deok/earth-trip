import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 여행 정보를 카드 형태로 렌더링하는 UI 컴포넌트
class PlanCard extends StatelessWidget {
  final String title;
  final String flagAsset;
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
    required this.title,
    required this.flagAsset,
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
    final dateFmt = DateFormat('yyyy-MM-dd');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목, 국기, D-day 표시
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  flagAsset,
                  width: 40,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              // Expanded로 감싸서 텍스트가 넘치지 않게 함
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // 길면 ... 처리
                ),
              ),
              const Spacer(),
              Text('D-$daysLeft', style: const TextStyle(color: Colors.green)),
            ],
          ),
          const SizedBox(height: 4),
          // 날짜 범위
          Text('${dateFmt.format(startDate)} - ${dateFmt.format(endDate)}'),
          const SizedBox(height: 8),
          // 비행, 숙박 시간 및 비용 정보
          Row(
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
              Text(
                NumberFormat.currency(
                  locale: 'ko_KR',
                  symbol: '₩',
                ).format(cost),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 좋아요 및 참여 인원
          Row(
            children: [
              const Icon(Icons.favorite_border, size: 16),
              const SizedBox(width: 4),
              Text('\$likes'),
              const SizedBox(width: 16),
              const Icon(Icons.person, size: 16),
              const SizedBox(width: 4),
              Text('\$participants'),
            ],
          ),
        ],
      ),
    );
  }
}
