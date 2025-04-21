import '../../domain/entities/plan_entity.dart';

/// JSON 형식 응답을 도메인 엔티티로 변환할 때 사용하는 모델 클래스
class PlanModel extends PlanEntity {
  PlanModel({
    required super.title,
    required super.start,
    required super.end,
    required super.cost,
    required super.daysLeft,
    required super.flightDuration,
    required super.stayDuration,
    required super.likes,
    required super.participants,
  });

  /// JSON 맵을 받아 필드 매핑 후 새 PlanModel 객체 생성
  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      title: json['title'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      cost: json['cost'],
      daysLeft: json['daysLeft'],
      flightDuration: json['flight'],
      stayDuration: json['stay'],
      likes: json['likes'],
      participants: json['participants'],
    );
  }
}
