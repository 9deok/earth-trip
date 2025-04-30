import '../../domain/entities/plan_entity.dart';

/// JSON 형식 응답을 도메인 엔티티로 변환할 때 사용하는 모델 클래스
class PlanModel extends PlanEntity {
  PlanModel({
    required super.id,
    required super.title,
    required super.start,
    required super.end,
    super.imageUrl,
    super.cost,
    super.daysLeft,
    super.flightDuration,
    super.stayDuration,
    super.likes,
    super.participants,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'],
      title: json['title'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      imageUrl: json['imageUrl'],
      cost: json['cost'],
      daysLeft: json['daysLeft'],
      flightDuration: json['flightDuration'],
      stayDuration: json['stayDuration'],
      likes: json['likes'],
      participants: json['participants'],
    );
  }
}
