import '../../../../core/usecases/common_use_case.dart';
import '../entities/diary_entry_entity.dart';
import '../repositories/diary_repository.dart';

class DiaryTripSummary {
  final String planId;
  final String title; // fallback planId if no title available yet
  final DateTime start;
  final DateTime end;
  final String? coverUrl;
  final String? retrospectiveText;
  final int entryCount;

  DiaryTripSummary({
    required this.planId,
    required this.title,
    required this.start,
    required this.end,
    this.coverUrl,
    this.retrospectiveText,
    required this.entryCount,
  });
}

class GetDiaryTripsUseCase
    implements CommonUseCase<List<DiaryTripSummary>, void> {
  final DiaryRepository repository;
  GetDiaryTripsUseCase(this.repository);

  @override
  Future<List<DiaryTripSummary>> call(void params) async {
    final all = await repository.listAll();
    final byPlan = <String, List<DiaryEntryEntity>>{};
    for (final e in all) {
      byPlan.putIfAbsent(e.planId, () => []).add(e);
    }
    final result = <DiaryTripSummary>[];
    for (final entry in byPlan.entries) {
      final list = entry.value..sort((a, b) => a.date.compareTo(b.date));
      final start = list.first.date;
      final end = list.last.date;
      final cover =
          list
              .firstWhere((e) => e.photoUrl != null, orElse: () => list.first)
              .photoUrl;
      final retro = list
          .where((e) => e.isRetrospective)
          .map((e) => e.text)
          .cast<String?>()
          .firstWhere((e) => e != null, orElse: () => null);
      result.add(
        DiaryTripSummary(
          planId: entry.key,
          title: entry.key,
          start: start,
          end: end,
          coverUrl: cover,
          retrospectiveText: retro,
          entryCount: list.length,
        ),
      );
    }
    result.sort((a, b) => b.start.compareTo(a.start));
    return result;
  }
}
