import 'package:avora/features/auth/domain/use_cases/sign_up_with_email.dart';
import 'package:avora/features/auth/presentation/sign_up_cubit/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this._signUpUseCase,
  })  : super(const SignUpInitial());

  final SignUpWithEmailAndPasswordUseCase _signUpUseCase;

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(const SignUpLoading());

    final result = await _signUpUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        emit(
          SignUpFailure(failure.message),
        );
      },
      (user) {
        emit(
          SignUpSuccess(user: user),
        );
      },
    );
  }
}