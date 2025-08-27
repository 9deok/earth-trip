import 'package:uuid/uuid.dart';

class DiaryEntryEntity {
  final String id;
  final DateTime date;
  final int moodScore; // 1..5
  final String text; // <= 300 chars
  final String? photoUrl; // optional
  final String planId; // 여행(Plan) 식별자
  final bool isRetrospective; // 총 회고 여부

  DiaryEntryEntity({
    required this.id,
    required this.date,
    required this.moodScore,
    required this.text,
    this.photoUrl,
    required this.planId,
    this.isRetrospective = false,
  });

  factory DiaryEntryEntity.createNew({
    required DateTime date,
    required int moodScore,
    required String text,
    String? photoUrl,
    required String planId,
    bool isRetrospective = false,
  }) => DiaryEntryEntity(
    id: const Uuid().v4(),
    date: date,
    moodScore: moodScore,
    text: text,
    photoUrl: photoUrl,
    planId: planId,
    isRetrospective: isRetrospective,
  );

  factory DiaryEntryEntity.fromJson(Map<String, dynamic> e) => DiaryEntryEntity(
    id: e['id'] ?? const Uuid().v4(),
    date: DateTime.parse(e['date']),
    moodScore: e['moodScore'] ?? 3,
    text: e['text'] ?? '',
    photoUrl: e['photoUrl'],
    planId: e['planId'] ?? '',
    isRetrospective: e['isRetrospective'] == true,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'moodScore': moodScore,
    'text': text,
    'photoUrl': photoUrl,
    'planId': planId,
    'isRetrospective': isRetrospective,
  };
}
