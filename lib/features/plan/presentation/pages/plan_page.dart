import 'package:earth_trip/features/plan/data/dummy_plan_data.dart';
import 'package:flutter/material.dart';
import '../widgets/plan_card.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터 조회
    final plans = DummyPlanRepository.fetchUpcomingPlans();

    return Scaffold(
      appBar: AppBar(title: const Text('내 계획 (더미 데이터)')),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final p = plans[index];
          return PlanCard(
            title: p.title,
            flagAsset:
                'assets/flags/${p.title.toLowerCase().replaceAll(' ', '_')}.png',
            startDate: p.start,
            endDate: p.end,
            daysLeft: p.daysLeft,
            flightDuration: p.flightDuration,
            stayDuration: p.stayDuration,
            cost: p.cost,
            likes: p.likes,
            participants: p.participants,
          );
        },
      ),
      floatingActionButton: SizedBox(
        height: 40, // 원하는 높이
        child: ElevatedButton.icon(
          onPressed: () {
            // TODO: 여행 계획 추가 화면으로 이동 또는 다이얼로그 띄우기
          },
          icon: const Icon(Icons.add, size: 18),
          label: const Text('여행 계획 추가하기', style: TextStyle(fontSize: 14)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            minimumSize: const Size(0, 40), // 최소 높이
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 4,
          ),
        ),
      ),
    );
  }
}
