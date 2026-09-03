enum UserIdentifierType {
  phone,
  username,
}

class UserIdentifier {
  const UserIdentifier({
    required this.type,
    required this.value,
  });

  final UserIdentifierType type;
  final String value;
}