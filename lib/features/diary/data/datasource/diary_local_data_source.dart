import '../../domain/entities/diary_entry_entity.dart';

abstract class DiaryLocalDataSource {
  Future<List<DiaryEntryEntity>> listByMonth(int year, int month);
  Future<List<DiaryEntryEntity>> listByPlan(String planId);
  Future<List<DiaryEntryEntity>> listAll();
  Future<void> save(DiaryEntryEntity entry);
  Future<void> delete(String id);
}
