import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/get_diary_trips_use_case.dart';
import 'diary_trip_view.dart';
import '../../../../features/plan/domain/usecases/get_plans_use_case.dart';
import '../../../../features/plan/domain/entities/plan_entity.dart';
import '../../../../core/i18n/strings.dart';
import '../../domain/usecases/get_diary_by_plan_use_case.dart';
import '../../domain/entities/diary_entry_entity.dart';

class DiaryTripsView extends StatefulWidget {
  const DiaryTripsView({super.key});

  @override
  State<DiaryTripsView> createState() => _DiaryTripsViewState();
}

class _DiaryTripsViewState extends State<DiaryTripsView> {
  Widget _buildImage(String? url, {double height = 200}) {
    if (url == null || url.isEmpty) {
      return Container(height: height, color: Colors.black12);
    }
    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (c, _) => Container(height: height, color: Colors.black12),
        errorWidget:
            (c, _, __) => Container(height: height, color: Colors.black12),
      );
    }
    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      // ignore: prefer_interpolation_to_compose_strings
      // 로컬 파일 경로 가정
      File(url),
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
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

        final dateFmt = DateFormat('yy.MM.dd');
        return ListView.builder(
          itemCount: combined.length,
          itemBuilder: (context, index) {
            final t = combined[index];
            final plan = planMap[t.planId];
            return _DiaryTripCard(
              summary: t,
              plan: plan,
              dateFmt: dateFmt,
              buildImage: _buildImage,
              onChanged: () => setState(() {}),
            );
          },
        );
      },
    );
  }
}

class _DiaryTripCard extends StatefulWidget {
  final DiaryTripSummary summary;
  final PlanEntity? plan;
  final DateFormat dateFmt;
  final Widget Function(String? url, {double height}) buildImage;
  final VoidCallback? onChanged;

  const _DiaryTripCard({
    required this.summary,
    required this.plan,
    required this.dateFmt,
    required this.buildImage,
    this.onChanged,
  });

  @override
  State<_DiaryTripCard> createState() => _DiaryTripCardState();
}

class _DiaryTripCardState extends State<_DiaryTripCard> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final t = widget.summary;
    final plan = widget.plan;
    final getByPlan = context.read<GetDiaryByPlanUseCase>();
    final dayFmt = DateFormat('yyyy.MM.dd (E)', 'ko_KR');
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () async {
          final changed = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DiaryTripView(planId: t.planId)),
          );
          if (changed == true) {
            setState(() {});
            widget.onChanged?.call();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    plan?.title ?? t.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    plan != null
                        ? '${widget.dateFmt.format(plan.start)} ~ ${widget.dateFmt.format(plan.end)}'
                        : '${widget.dateFmt.format(t.start)} ~ ${widget.dateFmt.format(t.end)}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            if (t.entryCount > 0)
              FutureBuilder<List<DiaryEntryEntity>>(
                future: getByPlan.call(t.planId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(height: 200, color: Colors.black12);
                  }
                  final entries = snapshot.data!;
                  if (entries.isEmpty) {
                    return widget.buildImage(
                      t.coverUrl ?? plan?.imageUrl,
                      height: 200,
                    );
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: 260,
                        child: PageView.builder(
                          onPageChanged: (i) => setState(() => _current = i),
                          itemCount: entries.length,
                          itemBuilder: (context, index) {
                            final e = entries[index];
                            final raw = e.text.trim();
                            final preview =
                                raw.length > 50
                                    ? '${raw.substring(0, 50)}…'
                                    : raw;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    widget.buildImage(e.photoUrl, height: 200),
                                    Positioned(
                                      right: 8,
                                      bottom: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          dayFmt.format(e.date),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    preview,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(entries.length, (i) {
                          final active = i == _current;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 12,
                            ),
                            width: active ? 10 : 6,
                            height: active ? 10 : 6,
                            decoration: BoxDecoration(
                              color: active ? Colors.black54 : Colors.black26,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              )
            else if ((t.coverUrl ?? plan?.imageUrl) != null)
              Stack(
                children: [
                  widget.buildImage(t.coverUrl ?? plan?.imageUrl, height: 200),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${Strings.Diary.entryCountPrefix} ${t.entryCount}${Strings.Diary.entryCountSuffix}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            if (t.retrospectiveText != null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  t.retrospectiveText!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
