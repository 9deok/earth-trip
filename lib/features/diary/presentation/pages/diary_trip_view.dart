import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/diary_trip_controller.dart';
import '../../domain/usecases/get_diary_by_plan_use_case.dart';
import '../../domain/usecases/save_diary_use_case.dart';
import '../../domain/usecases/delete_diary_use_case.dart';
import '../widgets/diary_entry_form.dart';
import '../../../plan/domain/usecases/get_plans_use_case.dart';
import '../../../plan/domain/entities/plan_entity.dart';
import '../../../../core/i18n/strings.dart';

class DiaryTripView extends StatelessWidget {
  final String planId;
  const DiaryTripView({super.key, required this.planId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => DiaryTripController(
            getByPlan: context.read<GetDiaryByPlanUseCase>(),
            saveDiaryUseCase: context.read<SaveDiaryUseCase>(),
            deleteDiaryUseCase: context.read<DeleteDiaryUseCase>(),
            planId: planId,
          )..load(),
      child: const _DiaryTripBody(),
    );
  }
}

class _DiaryTripBody extends StatefulWidget {
  const _DiaryTripBody();
  @override
  State<_DiaryTripBody> createState() => _DiaryTripBodyState();
}

class _DiaryTripBodyState extends State<_DiaryTripBody> {
  final PageController _controller = PageController();
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildImage(String? url) {
    if (url == null) return Container(height: 180, color: Colors.black12);
    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (c, _) => Container(height: 180, color: Colors.black12),
        errorWidget:
            (c, _, __) => Container(height: 180, color: Colors.black12),
      );
    }
    return Image.file(File(url), fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<DiaryTripController>();
    if (c.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final entries = c.entries;
    final plansUseCase = context.read<GetPlansUseCase>();
    return Scaffold(
      appBar: AppBar(title: Text(Strings.Diary.title)),
      body: FutureBuilder<List<PlanEntity>>(
        future: plansUseCase.call(null),
        builder: (context, snap) {
          final plan = (snap.data ?? []).firstWhere(
            (p) => p.id == c.planId,
            orElse:
                () => PlanEntity(
                  id: c.planId,
                  title: c.planId,
                  start: DateTime.now(),
                  end: DateTime.now(),
                  imageUrl: null,
                  cost: null,
                  daysLeft: null,
                  flightDuration: '',
                  stayDuration: '',
                  likes: 0,
                  participants: 0,
                ),
          );
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      plan.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${DateFormat('yy.MM.dd').format(plan.start)} ~ ${DateFormat('yy.MM.dd').format(plan.end)}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _current = i),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final e = entries[index];
                    final dayFmt = DateFormat('yyyy.MM.dd (E)', 'ko_KR');
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: [
                                  _buildImage(e.photoUrl),
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
                                        dayFmt.format(e.date),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '😊 ${e.moodScore}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () async {
                                        final navigator = Navigator.of(context);
                                        final updated =
                                            await showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder:
                                                  (_) => DiaryEntryForm(
                                                    planId: c.planId,
                                                    initial: e,
                                                  ),
                                            );
                                        if (updated != null) {
                                          await c.saveOrUpdate(updated);
                                          navigator.pop(true);
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      onPressed: () async {
                                        final navigator = Navigator.of(context);
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder:
                                              (ctx) => AlertDialog(
                                                title: Text(
                                                  Strings
                                                      .Diary
                                                      .confirmDeleteTitle,
                                                ),
                                                content: Text(
                                                  Strings.Diary.confirmDelete,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed:
                                                        () => Navigator.pop(
                                                          ctx,
                                                          false,
                                                        ),
                                                    child: Text(
                                                      Strings.Common.cancel,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed:
                                                        () => Navigator.pop(
                                                          ctx,
                                                          true,
                                                        ),
                                                    child: Text(
                                                      Strings.Diary.delete,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        );
                                        if (confirm == true) {
                                          await c.delete(e.id);
                                          navigator.pop(true);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(e.text),
                          ],
                        ),
                      ),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final navigator = Navigator.of(context);
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => DiaryEntryForm(planId: c.planId),
          );
          if (result != null) {
            await c.saveOrUpdate(result);
            navigator.pop(true);
          }
        },
        icon: const Icon(Icons.edit),
        label: Text(Strings.Diary.writeToday),
      ),
    );
  }
}
