import '../../../../core/usecases/common_use_case.dart';
import '../entities/diary_entry_entity.dart';
import '../repositories/diary_repository.dart';

class GetDiaryByPlanUseCase
    implements CommonUseCase<List<DiaryEntryEntity>, String> {
  final DiaryRepository repository;
  GetDiaryByPlanUseCase(this.repository);

  @override
  Future<List<DiaryEntryEntity>> call(String planId) {
    return repository.listByPlan(planId);
  }
}
