import 'package:avora/features/auth/domain/use_cases/update_password.dart';
import 'package:avora/features/auth/presentation/reset_pass_cubit/reset_pass_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassCubit extends Cubit<ResetPassState> {
  ResetPassCubit({required this._updatePasswordUseCase})
    : super(const ResetPassInitial());

  final UpdatePasswordUseCase _updatePasswordUseCase;

  Future<void> updatePassword({required String password}) async {
    emit(ResetPassLoading());

    final result = await _updatePasswordUseCase.call(password: password);
    result.fold(
      (failure) {
        emit(ResetPassFailure(message: failure.message));
      },
      (_) {
        emit(const ResetPassSuccess());
      },
    );
  }
}
