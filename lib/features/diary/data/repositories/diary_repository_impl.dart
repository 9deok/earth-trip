import '../../domain/entities/diary_entry_entity.dart';
import '../../domain/repositories/diary_repository.dart';
import '../datasource/diary_local_data_source.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryLocalDataSource local;
  DiaryRepositoryImpl(this.local);

  @override
  Future<void> delete(String id) => local.delete(id);

  @override
  Future<List<DiaryEntryEntity>> listByMonth(int year, int month) =>
      local.listByMonth(year, month);

  @override
  Future<void> save(DiaryEntryEntity entry) => local.save(entry);
}
