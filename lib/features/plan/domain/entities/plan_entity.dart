/// 앱 내에서 사용하는 여행 계획 도메인 객체
class PlanEntity {
  final String title; // 여행명
  final String? imageUrl; // 이미지 경로 (String, optional)
  final DateTime start; // 시작일
  final DateTime end; // 종료일
  final int? cost; // 예상 비용(원, optional)
  final int? daysLeft; // D-day 계산 결과 (optional)
  final String? flightDuration; // 비행 시간 표시 (optional)
  final String? stayDuration; // 체류 시간 표시 (optional)
  final int? likes; // 좋아요 수 (optional)
  final int? participants; // 동행 인원수 (optional)

  PlanEntity({
    required this.title,
    required this.start,
    required this.end,
    this.imageUrl,
    this.cost,
    this.daysLeft,
    this.flightDuration,
    this.stayDuration,
    this.likes,
    this.participants,
  });

  static PlanEntity fromJson(e) {
    return PlanEntity(
      title: e['title'],
      start: DateTime.parse(e['start']),
      end: DateTime.parse(e['end']),
      imageUrl: e['imageUrl'],
      cost: e['cost'],
      daysLeft: e['daysLeft'],
      flightDuration: e['flightDuration'],
      stayDuration: e['stayDuration'],
      likes: e['likes'],
      participants: e['participants'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'imageUrl': imageUrl,
      'cost': cost,
      'daysLeft': daysLeft,
      'flightDuration': flightDuration,
      'stayDuration': stayDuration,
      'likes': likes,
      'participants': participants,
    };
  }
}
