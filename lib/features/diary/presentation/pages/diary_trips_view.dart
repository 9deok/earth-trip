import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/get_diary_trips_use_case.dart';
import '../../../../features/plan/domain/usecases/get_plans_use_case.dart';
import '../../../../features/plan/domain/entities/plan_entity.dart';
import '../widgets/diary_trip_card.dart';

class DiaryTripsView extends StatefulWidget {
  const DiaryTripsView({super.key});

  @override
  State<DiaryTripsView> createState() => _DiaryTripsViewState();
}

class _DiaryTripsViewState extends State<DiaryTripsView> {
  @override
  Widget build(BuildContext context) {
    final tripsUseCase = context.read<GetDiaryTripsUseCase>();
    final plansUseCase = context.read<GetPlansUseCase>();
    return FutureBuilder(
      future: Future.wait([tripsUseCase.call(null), plansUseCase.call(null)]),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snap.data! as List<dynamic>;
        final trips = data[0] as List<DiaryTripSummary>;
        final plans = (data[1] as List<PlanEntity>);
        final planMap = {for (final p in plans) p.id: p};
        // 모든 Plan을 기준으로 보여주고, trips로 보조 데이터(entryCount/retrospective)를 채운다
        final tripMap = {for (final t in trips) t.planId: t};
        final combined =
            plans.map((p) {
                final t = tripMap[p.id];
                return DiaryTripSummary(
                  planId: p.id,
                  title: p.title,
                  start: p.start,
                  end: p.end,
                  coverUrl: t?.coverUrl ?? p.imageUrl,
                  retrospectiveText: t?.retrospectiveText,
                  entryCount: t?.entryCount ?? 0,
                );
              }).toList()
              ..sort((a, b) => b.start.compareTo(a.start));

        return ListView.builder(
          itemCount: combined.length,
          itemBuilder: (context, index) {
            final t = combined[index];
            final plan = planMap[t.planId];
            return DiaryTripCard(
              summary: t,
              plan: plan,
              onChanged: () => setState(() {}),
            );
          },
        );
      },
    );
  }
}
