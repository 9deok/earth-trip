import '../../../../core/usecases/common_use_case.dart';
import '../entities/plan_entity.dart';
import '../repositories/plan_repository.dart';

class SavePlanUseCase implements CommonUseCase<void, PlanEntity> {
  final PlanRepository repository;
  SavePlanUseCase(this.repository);

  @override
  Future<void> call(PlanEntity params) {
    return repository.savePlan(params);
  }
}
