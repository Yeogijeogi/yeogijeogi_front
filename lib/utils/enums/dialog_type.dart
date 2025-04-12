enum DialogType {
  logout(title: '로그아웃 하시겠어요?', body: '언제든지 다시 로그인할 수 있어요.', action: '로그아웃'),
  deleteAccount(
    title: '회원을 탈퇴하시겠어요?',
    body: '이 작업은 다시 되돌릴 수 없어요.',
    action: '회원탈퇴',
  ),
  notSave(title: '저장하지 않고 종료할까요?', body: '코스 데이터가 저장되지 않고 사라져요.', action: '종료'),
  deleteCourse(title: '코스를 삭제할까요?', body: '이 작업은 다시 되돌릴 수 없어요.', action: '삭제'),
  location(
    title: '위치 권한을 허용해주세요.',
    body: '앱을 사용하기 위해서는 위치 권한이 필요합니다.',
    action: '설정',
  );

  /// 제목 텍스트
  final String title;

  /// 설명 텍스트
  final String body;

  /// 액션 텍스트
  final String action;

  const DialogType({
    required this.title,
    required this.body,
    required this.action,
  });
}
