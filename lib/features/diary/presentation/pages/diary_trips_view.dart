import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/get_diary_trips_use_case.dart';
import '../../../../features/plan/domain/usecases/get_plans_use_case.dart';
import '../../../../features/plan/domain/entities/plan_entity.dart';
import '../../../../core/i18n/strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../controllers/diary_trips_controller.dart';
import '../widgets/diary_trip_card.dart';
import '../../../../core/widgets/shimmer_box.dart';

class DiaryTripsView extends StatefulWidget {
  const DiaryTripsView({super.key});

  @override
  State<DiaryTripsView> createState() => _DiaryTripsViewState();
}

class _DiaryTripsViewState extends State<DiaryTripsView> {
  DiaryTripsFilter get _filter => context.watch<DiaryTripsController>().filter;

  Widget _buildFilters(BuildContext context) {
    final items = <Map<String, dynamic>>[
      {'label': Strings.Diary.filterAll, 'value': DiaryTripsFilter.all},
      {
        'label': Strings.Diary.filterHasEntries,
        'value': DiaryTripsFilter.hasEntries,
      },
      {
        'label': Strings.Diary.filterHasRetrospective,
        'value': DiaryTripsFilter.hasRetro,
      },
    ];
    return Wrap(
      spacing: 8,
      children:
          items.map((it) {
            final v = it['value'] as DiaryTripsFilter;
            final selected = _filter == v;
            return ChoiceChip(
              label: Text(it['label'] as String),
              selected: selected,
              onSelected:
                  (_) => context.read<DiaryTripsController>().setFilter(v),
            );
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripsUseCase = context.read<GetDiaryTripsUseCase>();
    final plansUseCase = context.read<GetPlansUseCase>();
    return FutureBuilder(
      future: Future.wait([tripsUseCase.call(null), plansUseCase.call(null)]),
      builder: (context, snap) {
        if (!snap.hasData) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _SkeletonCard(),
                ),
          );
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

        final filtered =
            combined.where((t) {
              switch (_filter) {
                case DiaryTripsFilter.all:
                  return true;
                case DiaryTripsFilter.hasEntries:
                  return (t.entryCount) > 0;
                case DiaryTripsFilter.hasRetro:
                  return (t.retrospectiveText ?? '').trim().isNotEmpty;
              }
            }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(Strings.Diary.title, style: AppTextStyles.titleLg),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _buildFilters(context),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final t = filtered[index];
                  final plan = planMap[t.planId];
                  return DiaryTripCard(
                    summary: t,
                    plan: plan,
                    onChanged: () => setState(() {}),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerBox(
            height: 180,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const ShimmerBox(
              height: 14,
              width: 140,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const ShimmerBox(
              height: 12,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
