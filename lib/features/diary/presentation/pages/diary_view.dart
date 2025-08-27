import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/i18n/strings.dart';
import 'package:provider/provider.dart';
import '../controllers/diary_controller.dart';
import '../widgets/diary_entry_form.dart';

class DiaryView extends StatelessWidget {
  const DiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<DiaryController>();
    if (c.isLoading) return const Center(child: CircularProgressIndicator());
    final monthFmt = DateFormat('yyyy.MM');

    return Scaffold(
      appBar: AppBar(title: Text(Strings.Diary.title)),
      body: ListView.separated(
        itemCount: c.entries.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final e = c.entries[index];
          final dayFmt = DateFormat('MM.dd (E)', 'ko_KR');
          return ListTile(
            title: Text(dayFmt.format(e.date)),
            subtitle: Text(
              e.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text('😊 ${e.moodScore}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet<DiaryEntryPayload>(
            context: context,
            isScrollControlled: true,
            builder: (_) => const DiaryEntryForm(),
          );
          if (result != null) {
            // 임시: 단일 여행 컨텍스트가 없으므로 기본 planId 사용(추후 라우팅에서 주입)
            await c.addOrUpdate(result.toEntity('default-plan'));
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _MoodChart(entries: c.entries),
    );
  }
}

class _MoodChart extends StatelessWidget {
  final List entries;
  const _MoodChart({required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();
    final spots = <FlSpot>[];
    for (var i = 0; i < entries.length; i++) {
      spots.add(FlSpot((i + 1).toDouble(), entries[i].moodScore.toDouble()));
    }
    return SizedBox(
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: LineChart(
          LineChartData(
            minY: 1,
            maxY: 5,
            titlesData: FlTitlesData(show: false),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.orange,
                barWidth: 3,
                dotData: const FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
