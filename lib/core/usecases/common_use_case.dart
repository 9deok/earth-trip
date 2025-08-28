/// 비즈니스 로직 실행 인터페이스를 정의한 추상 클래스
/// Output: 반환 타입, Params: 입력 파라미터 타입
abstract class CommonUseCase<Output, Params> {
  /// 실제 유스케이스 로직 수행 메서드
  Future<Output> call(Params params);
}
