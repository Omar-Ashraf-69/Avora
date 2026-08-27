import 'package:avora/features/auth/domain/use_cases/sign_in_with_email.dart';
import 'package:avora/features/auth/domain/use_cases/sign_in_with_google.dart';
import 'package:avora/features/auth/presentation/login_cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this._signInWithEmailUseCase,
    required this._signInWithGoogleUseCase,
  })  : super(const LoginInitial());

  final SignInWithEmailAndPasswordUseCase _signInWithEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());

    final result = await _signInWithEmailUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        emit(LoginFailure(failure.message));
      },
      (user) {
        emit(LoginSuccess(user: user));
      },
    );
  }

  Future<void> signInWithGoogle() async {
    emit(const LoginLoading());

    final result = await _signInWithGoogleUseCase();

    result.fold(
      (failure) {
        emit(LoginFailure(failure.message));
      },
      (user) {
        emit(LoginSuccess(user: user));
      },
    );
  }
}