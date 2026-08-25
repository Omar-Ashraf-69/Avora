import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/auth/domain/use_cases/get_current_user.dart';
import 'package:avora/features/auth/domain/use_cases/sign_in_with_email.dart';
import 'package:avora/features/auth/domain/use_cases/sign_in_with_google.dart';
import 'package:avora/features/auth/domain/use_cases/sign_out.dart';
import 'package:avora/features/auth/domain/use_cases/sign_up_with_email.dart';
import 'package:avora/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  void getCurrentUser() {
    final user = GetCurrentUserUseCase(getIt<AuthRepository>()).call();

    if (user == null) {
      emit(const AuthUnauthenticated());
      return;
    }

    emit(CurrentUser(user: user));
  }

  Future<void> signOut() async {
    emit(const AuthLoading());

    try {
      await SignOutUseCase(getIt<AuthRepository>()).call();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUpNewUser({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final res = await SignUpWithEmailAndPasswordUseCase(
      getIt<AuthRepository>(),
    ).call(email: email, password: password);
    res.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(Authenticated(user: r)),
    );
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final res = await SignInWithEmailAndPasswordUseCase(
      getIt<AuthRepository>(),
    ).call(email: email, password: password);
    res.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(Authenticated(user: r)),
    );
  }
   Future<void> signInWithGoogle() async{
    emit(const AuthLoading());

    final res = await SignInWithGoogleUseCase(
      getIt<AuthRepository>(),
    ).call();
    res.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(Authenticated(user: r)),
    );
  }
}
