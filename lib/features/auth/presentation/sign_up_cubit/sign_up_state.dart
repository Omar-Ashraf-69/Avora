import 'package:avora/features/auth/data/models/user_model.dart';

sealed class SignUpState {
  const SignUpState();
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

final class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

final class SignUpSuccess extends SignUpState {
  final UserModel user;

  const SignUpSuccess({
    required this.user,
  });
}

final class SignUpFailure extends SignUpState {
  final String message;

  const SignUpFailure(this.message);
}