import '../../../../core/usecases/common_use_case.dart';
import '../repositories/plan_repository.dart';

class DeletePlanUseCase implements CommonUseCase<void, String> {
  final PlanRepository repository;
  DeletePlanUseCase(this.repository);

  @override
  Future<void> call(String id) {
    return repository.deletePlan(id);
  }
}
