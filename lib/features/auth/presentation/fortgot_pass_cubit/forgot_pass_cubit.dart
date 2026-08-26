import 'dart:developer';

import 'package:avora/features/auth/domain/use_cases/send_password_reset.dart';
import 'package:avora/features/auth/presentation/fortgot_pass_cubit/forgot_pass_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassCubit extends Cubit<ForgotPassState> {
  ForgotPassCubit({required this._sendPasswordResetEmailUseCase})
    : super(const ForgotPassInitial());

  final SendPasswordResetEmailUseCase _sendPasswordResetEmailUseCase;

  Future<void> sendResetEmail({required String email}) async {
    emit(ForgotPassLoading());
    log("sendResetEmail: $email");
    final result = await _sendPasswordResetEmailUseCase.call(
      email: email,
    );

    result.fold(
      (failure) {
        emit(ForgotPassFailure(message: failure.message));
      },
      (_) {
        emit(const ForgotPassSuccess());
      },
    );
  }
}
