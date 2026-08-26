import 'package:avora/features/auth/data/models/user_model.dart';
import 'package:avora/features/auth/domain/use_cases/delete_current_user.dart';
import 'package:avora/features/auth/domain/use_cases/get_current_user.dart';
import 'package:avora/features/auth/domain/use_cases/sign_in_with_email.dart';
import 'package:avora/features/auth/domain/use_cases/sign_in_with_google.dart';
import 'package:avora/features/auth/domain/use_cases/sign_out.dart';
import 'package:avora/features/auth/domain/use_cases/sign_up_with_email.dart';
import 'package:avora/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this._getCurrentUserUseCase,
    required this._signInWithEmailUseCase,
    required this._signInWithGoogleUseCase,
    required this._signUpWithEmailUseCase,
    required this._signOutUseCase,
    required this._deleteCurrentUserUseCase,
  })  : super(const AuthInitial());

  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SignInWithEmailAndPasswordUseCase
      _signInWithEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignUpWithEmailAndPasswordUseCase _signUpWithEmailUseCase;
  final SignOutUseCase _signOutUseCase;
  final DeleteCurrentUserUseCase _deleteCurrentUserUseCase;

  // ---------------------------------------------------------------------------
  // Current User
  // ---------------------------------------------------------------------------

  void getCurrentUser() {
    final user = _getCurrentUserUseCase();

    if (user == null) {
      emit(const Unauthenticated());
      return;
    }

    emit(
      Authenticated(
        user: UserModel(id: user.id, email: user.email!),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Sign In
  // ---------------------------------------------------------------------------

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final result = await _signInWithEmailUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        emit(
          AuthError(failure.message),
        );
      },
      (user) {
        emit(
          Authenticated(user: user),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Google Sign In
  // ---------------------------------------------------------------------------

  Future<void> signInWithGoogle() async {
    emit(const AuthLoading());

    final result = await _signInWithGoogleUseCase();

    result.fold(
      (failure) {
        emit(
          AuthError(failure.message),
        );
      },
      (user) {
        emit(
          Authenticated(user: user),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Sign Up
  // ---------------------------------------------------------------------------

  Future<void> signUpNewUser({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final result = await _signUpWithEmailUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        emit(
          AuthError(failure.message),
        );
      },
      (user) {
        emit(
          Authenticated(user: user),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Sign Out
  // ---------------------------------------------------------------------------

  Future<void> signOut() async {
    emit(const AuthLoading());

    final result = await _signOutUseCase();

    result.fold(
      (failure) {
        emit(
          AuthError(failure.message),
        );
      },
      (_) {
        emit(
          const Unauthenticated(),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Delete Account
  // ---------------------------------------------------------------------------

  Future<void> deleteCurrentUser() async {
    emit(const AuthLoading());

    final result = await _deleteCurrentUserUseCase();

    result.fold(
      (failure) {
        emit(
          AuthError(failure.message),
        );
      },
      (_) {
        emit(
          const Unauthenticated(),
        );
      },
    );
  }
}