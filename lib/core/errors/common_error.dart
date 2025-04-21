// lib/core/errors/app_error.dart
/// 전역에서 발생하는 예외를 감싸는 커스텀 에러 클래스
/// message: 에러 내용 설명
class CommonError implements Exception {
  final String message;
  CommonError(this.message);
  @override
  String toString() => 'AppError: $message';
}
