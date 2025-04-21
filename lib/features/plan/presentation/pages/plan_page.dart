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
    );
  }
}
