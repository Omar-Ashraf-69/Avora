class AuthUser {
  const AuthUser({
    required this.id,
    this.phone,
  });

  final String id;
  final String? phone;
}