import 'dart:async';

import 'package:avora/core/auth/cubit/session_state.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/profile/domain/use_cases/get_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({
    required this._authRepository,
    required this._getProfileUseCase,
    required this._supabase,
  })  : super(const SessionInitial()) {
    _init();
  }

  final AuthRepository _authRepository;
  final GetProfileUseCase _getProfileUseCase;
  final SupabaseClient _supabase;

  StreamSubscription<AuthState>? _authStateSubscription;

  void _init() {
    _authStateSubscription = _supabase.auth.onAuthStateChange.listen(
      (data) {
        _handleAuthStateChange(data.event);
      },
    );
  }

  Future<void> checkSession() async {
    // If state is already resolved to the same state, avoid triggering redundant re-loading
    if (state is SessionLoading) return;

    emit(const SessionLoading());

    final user = _authRepository.getCurrentUser();

    if (user == null) {
      emit(const SessionUnauthenticated());
      return;
    }

    await _checkProfile(user.id);
  }

  Future<void> _checkProfile(String userId) async {
    final result = await _getProfileUseCase.call(userId: userId);

    result.fold(
      (failure) => emit(SessionFailure(failure.message)),
      (profile) {
        if (profile == null) {
          emit(const SessionProfileIncomplete());
        } else {
          emit(SessionAuthenticated(profile: profile));
        }
      },
    );
  }

  Future<void> _handleAuthStateChange(AuthChangeEvent event) async {
    switch (event) {
      case AuthChangeEvent.initialSession:
      case AuthChangeEvent.signedIn:
        await checkSession();
        break;

      case AuthChangeEvent.signedOut:
      // ignore: deprecated_member_use
      case AuthChangeEvent.userDeleted:
        emit(const SessionUnauthenticated());
        break;

      case AuthChangeEvent.tokenRefreshed:
      case AuthChangeEvent.userUpdated:
      case AuthChangeEvent.passwordRecovery:
      case AuthChangeEvent.mfaChallengeVerified:
        // Background operational events must NOT trigger session re-evaluation 
        // to prevent unintended UI resets.
        break;
    }
  }

  @override
  Future<void> close() async {
    await _authStateSubscription?.cancel();
    return super.close();
  }
}