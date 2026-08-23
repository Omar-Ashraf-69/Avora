import 'package:supabase_flutter/supabase_flutter.dart';

class AuthUserModel {
  final String email;
  final String id;
  final String? pass;
  const AuthUserModel({required this.id,  this.pass,required this.email});

  factory AuthUserModel.fromSupabase(User user) {
    return AuthUserModel(id: user.id, email: user.email!);
  }

}
