import '../../../../core/usecases/common_use_case.dart';
import '../entities/diary_entry_entity.dart';
import '../repositories/diary_repository.dart';

class GetDiaryByMonthUseCase
    implements CommonUseCase<List<DiaryEntryEntity>, DateTime> {
  final DiaryRepository repository;
  GetDiaryByMonthUseCase(this.repository);

  @override
  Future<List<DiaryEntryEntity>> call(DateTime params) {
    return repository.listByMonth(params.year, params.month);
  }
}
