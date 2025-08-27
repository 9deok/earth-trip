import '../../domain/entities/plan_entity.dart';
import '../../domain/repositories/plan_repository.dart';
import '../datasource/plan_remote_data_source.dart';

/// PlanRepository 인터페이스 구현체
/// 실제 데이터 소스(원격)를 통해 데이터를 반환
class PlanRepositoryImpl implements PlanRepository {
  final PlanRemoteDataSource remoteDataSource;
  PlanRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PlanEntity>> getUpcomingPlans() {
    return remoteDataSource.fetchUpcomingPlans();
  }

  @override
  Future<void> savePlan(PlanEntity plan) {
    return remoteDataSource.saveUserPlan(plan);
  }

  @override
  Future<void> deletePlan(String id) {
    return remoteDataSource.deleteUserPlan(id);
  }
}
