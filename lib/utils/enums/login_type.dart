enum LoginType {
  google(provider: 'google.com'),
  apple(provider: 'apple.com');

  final String provider;
  const LoginType({required this.provider});

  /// 입력된 provider에 해당하는 LoginType을 반환
  static LoginType? fromProvider(String provider) {
    return LoginType.values.cast<LoginType?>().firstWhere(
      (e) => e?.provider == provider,
      orElse: () => null,
    );
  }
}
