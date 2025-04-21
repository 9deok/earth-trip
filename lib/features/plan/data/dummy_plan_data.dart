import 'package:earth_trip/features/plan/domain/entities/plan_entity.dart';

class DummyPlanRepository {
  static List<PlanEntity> fetchUpcomingPlans() => [
    PlanEntity(
      title: '전주 여행',
      start: DateTime(2025, 5, 1),
      end: DateTime(2025, 5, 1),
      cost: 596800,
      daysLeft: DateTime(2025, 5, 1).difference(DateTime.now()).inDays,
      flightDuration: '00시간 00분',
      stayDuration: '00시간 00분',
      likes: 0,
      participants: 2,
    ),
    PlanEntity(
      title: '스페인 여행',
      start: DateTime(2025, 9, 26),
      end: DateTime(2025, 10, 13),
      cost: 9580000,
      daysLeft: DateTime(2025, 9, 26).difference(DateTime.now()).inDays,
      flightDuration: '15시간 15분',
      stayDuration: '12시간 00분',
      likes: 23,
      participants: 2,
    ),
    PlanEntity(
      title: '발리 여행',
      start: DateTime(2026, 5, 26),
      end: DateTime(2026, 5, 31),
      cost: 3230000,
      daysLeft: DateTime(2026, 5, 26).difference(DateTime.now()).inDays,
      flightDuration: '7시간 15분',
      stayDuration: '8시간 20분',
      likes: 3,
      participants: 2,
    ),
  ];
}
