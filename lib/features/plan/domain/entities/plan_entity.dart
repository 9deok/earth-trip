/// 앱 내에서 사용하는 여행 계획 도메인 객체
class PlanEntity {
  final String title; // 여행명
  final DateTime start; // 시작일
  final DateTime end; // 종료일
  final int cost; // 예상 비용(원)
  final int daysLeft; // D-day 계산 결과
  final String flightDuration; // 비행 시간 표시
  final String stayDuration; // 체류 시간 표시
  final int likes; // 좋아요 수
  final int participants; // 동행 인원수

  PlanEntity({
    required this.title,
    required this.start,
    required this.end,
    required this.cost,
    required this.daysLeft,
    required this.flightDuration,
    required this.stayDuration,
    required this.likes,
    required this.participants,
  });
}
