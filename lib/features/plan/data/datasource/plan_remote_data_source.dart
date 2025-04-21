import '../../domain/entities/plan_entity.dart';

/// 원격 서버에서 여행 계획 데이터를 가져오는 인터페이스
abstract class PlanRemoteDataSource {
  /// 서버로부터 다가오는 여행 계획 리스트를 비동기로 반환
  Future<List<PlanEntity>> fetchUpcomingPlans();
}
