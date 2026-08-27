import 'package:avora/features/auth/data/models/user_model.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  final UserModel user;

  const LoginSuccess({
    required this.user,
  });
}

final class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);
}