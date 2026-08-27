import 'dart:async';

import 'package:avora/core/auth/cubit/session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({
    required this._supabase,
  })  : super(const SessionInitial());

  final SupabaseClient _supabase;

  StreamSubscription<AuthState>? _authSubscription;

  void initialize() {
    // Check the session that Supabase restored when the app started.
    final session = _supabase.auth.currentSession;

    if (session != null) {
      emit(const SessionAuthenticated());
    } else {
      emit(const SessionUnauthenticated());
    }

    // Listen for authentication changes while the app is running.
    _authSubscription ??= _supabase.auth.onAuthStateChange.listen(
      (authState) {
        switch (authState.event) {
          case AuthChangeEvent.signedIn:
          case AuthChangeEvent.tokenRefreshed:
          case AuthChangeEvent.userUpdated:
            emit(const SessionAuthenticated());
            break;

          case AuthChangeEvent.signedOut:
            emit(const SessionUnauthenticated());
            break;

          default:
            break;
        }
      },
    );
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}