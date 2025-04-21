// lib/features/plan/domain/usecases/get_plans_usecase.dart
import '../../../../core/usecases/common_use_case.dart';
import '../entities/plan_entity.dart';
import '../repositories/plan_repository.dart';

/// PlanRepository를 호출하는 유스케이스
class GetPlansUseCase implements CommonUseCase<List<PlanEntity>, void> {
  final PlanRepository repository;
  GetPlansUseCase(this.repository);

  @override
  Future<List<PlanEntity>> call(void params) {
    // repository 로부터 데이터 조회
    return repository.getUpcomingPlans();
  }
}
