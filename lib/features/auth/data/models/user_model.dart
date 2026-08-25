import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  final String email;
  final String id;
  final String? pass;
  const UserModel({required this.id,  this.pass,required this.email});

  factory UserModel.fromSupabase(User user) {
    return UserModel(id: user.id, email: user.email!);
  }

}
