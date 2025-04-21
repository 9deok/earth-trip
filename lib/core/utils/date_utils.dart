// lib/core/utils/date_utils.dart
/// 날짜 간격 계산을 위한 유틸리티 클래스
class DateUtils {
  /// 두 날짜 사이의 '일 수' 계산
  static int daysBetween(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }
}
