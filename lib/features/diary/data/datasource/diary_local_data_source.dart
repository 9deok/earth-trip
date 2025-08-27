import '../../domain/entities/diary_entry_entity.dart';

abstract class DiaryLocalDataSource {
  Future<List<DiaryEntryEntity>> listByMonth(int year, int month);
  Future<void> save(DiaryEntryEntity entry);
  Future<void> delete(String id);
}
