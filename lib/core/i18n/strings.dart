class Strings {
  static const appTitle = 'Travel Planner';

  // 정적 상수 인스턴스로 노출 (대문자 키 유지: 기존 사용처 호환)
  static const Common = _Common();
  static const Plan = _Plan();
  static const Nav = _Nav();
  static const Errors = _Errors();
  static const Diary = _Diary();
}

class _Common {
  const _Common();
  final String ok = '확인';
  final String cancel = '취소';
  final String delete = '삭제';
  final String add = '추가';
}

class _Plan {
  const _Plan();
  // Titles
  final String myPlans = '내 계획';
  final String addPlan = '여행 계획 추가';
  final String selectPlaceTitle = '여행 장소를 입력하세요';
  final String selectDateRangeTitle = '여행 일정을 선택하세요';

  // Buttons
  final String next = '다음';
  final String complete = '완료';

  // Dialog
  final String confirmDeleteTitle = '삭제 확인';
  final String confirmDeleteContent = '정말로 이 여행 계획을 삭제하시겠습니까?!!!';
  final String deletedSnack = '여행 계획이 삭제되었습니다.';
  final String emptyList = '등록된 계획이 없습니다.';
}

class _Nav {
  const _Nav();
  final String home = '홈';
  final String diary = '일기';
  final String plans = '내 계획';
  final String chat = '채팅';
  final String account = '계정';
}

class _Errors {
  const _Errors();
  final String saveFailed = '저장에 실패했습니다. 잠시 후 다시 시도해주세요.';
  final String deleteFailed = '삭제에 실패했습니다. 잠시 후 다시 시도해주세요.';
}

class _Diary {
  const _Diary();
  final String title = '내 여행 기록';
  final String writeToday = '오늘의 일기 쓰기';
  final String entryPlaceholder = '오늘의 기록 (최대 300자)';
  final String entryRequired = '내용을 입력하세요';
  final String mood = '기분';
  final String date = '날짜';
  final String save = '저장';
  final String edit = '편집';
  final String delete = '삭제';
  final String confirmDelete = '이 일기를 삭제할까요?';
}
