import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../domain/entities/auth_user.dart';

class AuthUserModel  {
  final String id;
  final String? phone;
  const AuthUserModel({
     required this.id, this.phone,
  });

  factory AuthUserModel.fromSupabase(User user) {
    return AuthUserModel(
      id: user.id,
      phone: user.phone,
    );
  }
  AuthUser toEntity() {
    return AuthUser(
      id: id,
      phone: phone,
    );
  }
}