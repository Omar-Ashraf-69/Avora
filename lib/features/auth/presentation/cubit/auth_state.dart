import 'package:avora/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class CurrentUser extends AuthState {
  final User user;
  const CurrentUser({required this.user});
}

class Authenticated extends AuthState {
  final UserModel user;
  const Authenticated({required this.user});
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class UserDeleted extends AuthState {
  const UserDeleted();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class AuthSignedIn extends AuthState {
  const AuthSignedIn();
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}
