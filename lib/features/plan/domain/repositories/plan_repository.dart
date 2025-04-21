import '../entities/plan_entity.dart';

/// 도메인 계층에서 정의한 여행 계획 저장소 인터페이스
abstract class PlanRepository {
  /// 다가오는 여행 계획 리스트 반환 계약
  Future<List<PlanEntity>> getUpcomingPlans();
}
