import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/get_diary_by_plan_use_case.dart';
import '../../domain/entities/diary_entry_entity.dart';
import '../../../plan/domain/entities/plan_entity.dart';
import '../../../../core/i18n/strings.dart';
import '../../../../core/widgets/adaptive_image.dart';
import '../pages/diary_trip_view.dart';
import '../widgets/styles/diary_trip_card_styles.dart';
import '../pages/sections/diary_trip_card_section.dart';
import '../../domain/usecases/get_diary_trips_use_case.dart';

class DiaryTripCard extends StatefulWidget {
  final DiaryTripSummary summary;
  final PlanEntity? plan;
  final VoidCallback? onChanged;

  const DiaryTripCard({
    super.key,
    required this.summary,
    required this.plan,
    this.onChanged,
  });

  @override
  State<DiaryTripCard> createState() => _DiaryTripCardState();
}

class _DiaryTripCardState extends State<DiaryTripCard> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final t = widget.summary;
    final plan = widget.plan;
    final getByPlan = context.read<GetDiaryByPlanUseCase>();
    final headerFmt = DateFormat('yy.MM.dd');
    final dayFmt = DateFormat('yyyy.MM.dd (E)', 'ko_KR');

    return DiaryTripCardSection(
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
              padding: DiaryTripCardStyles.contentPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    plan?.title ?? t.title,
                    style: DiaryTripCardStyles.headerTitleStyle(context),
                  ),
                  Text(
                    plan != null
                        ? '${headerFmt.format(plan.start)} ~ ${headerFmt.format(plan.end)}'
                        : '${headerFmt.format(t.start)} ~ ${headerFmt.format(t.end)}',
                    style: DiaryTripCardStyles.headerMetaStyle,
                  ),
                ],
              ),
            ),
            if (t.entryCount > 0)
              FutureBuilder<List<DiaryEntryEntity>>(
                future: getByPlan.call(t.planId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      height: DiaryTripCardStyles.imageHeight,
                      color: Colors.black12,
                    );
                  }
                  final entries = snapshot.data!;
                  if (entries.isEmpty) {
                    return AdaptiveImage(
                      urlOrPath: t.coverUrl ?? plan?.imageUrl,
                      height: DiaryTripCardStyles.imageHeight,
                      width: double.infinity,
                    );
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: DiaryTripCardStyles.imageHeight + 60,
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
                                    AdaptiveImage(
                                      urlOrPath: e.photoUrl,
                                      height: DiaryTripCardStyles.imageHeight,
                                      width: double.infinity,
                                    ),
                                    Positioned(
                                      right: 8,
                                      bottom: 8,
                                      child: Container(
                                        padding:
                                            DiaryTripCardStyles.badgePadding,
                                        decoration:
                                            DiaryTripCardStyles.overlayBadgeDecoration(
                                              context,
                                            ),
                                        child: Text(
                                          dayFmt.format(e.date),
                                          style:
                                              DiaryTripCardStyles
                                                  .badgeTextStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: DiaryTripCardStyles.previewPadding,
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
                            margin: DiaryTripCardStyles.indicatorMargin,
                            width:
                                active
                                    ? DiaryTripCardStyles.indicatorDotSizeActive
                                    : DiaryTripCardStyles.indicatorDotSize,
                            height:
                                active
                                    ? DiaryTripCardStyles.indicatorDotSizeActive
                                    : DiaryTripCardStyles.indicatorDotSize,
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
                  AdaptiveImage(
                    urlOrPath: t.coverUrl ?? plan?.imageUrl,
                    height: DiaryTripCardStyles.imageHeight,
                    width: double.infinity,
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: DiaryTripCardStyles.badgePadding,
                      decoration: DiaryTripCardStyles.overlayBadgeDecoration(
                        context,
                      ),
                      child: Text(
                        '${Strings.Diary.entryCountPrefix} ${t.entryCount}${Strings.Diary.entryCountSuffix}',
                        style: DiaryTripCardStyles.badgeTextStyle,
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
