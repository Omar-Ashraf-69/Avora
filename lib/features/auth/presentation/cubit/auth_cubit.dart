import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/auth/data/repos/auth_repo_impl.dart';
import 'package:avora/features/auth/domain/use_cases/get_current_user.dart';
import 'package:avora/features/auth/domain/use_cases/sign_out.dart';
import 'package:avora/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  String phoneNumber = '';

  void getCurrentUser() {
    final user = GetCurrentUserUseCase(getIt<AuthRepositoryImpl>()).call();

    if (user == null) {
      emit(const AuthUnauthenticated());
      return;
    }

    emit(AuthAuthenticated(user));
  }

  Future<void> signOut() async {
    emit(const AuthLoading());

    try {
      await SignOutUseCase(getIt<AuthRepositoryImpl>()).call();

      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
