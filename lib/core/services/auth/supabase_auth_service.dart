import 'dart:developer';

import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/supabase_exception_mapper.dart';
import 'package:avora/generated/l10n.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  SupabaseAuthService({
    required this._supabase,
    required this._googleSignIn,
  });

  final SupabaseClient _supabase;
  final GoogleSignIn _googleSignIn;

  GoTrueClient get _auth => _supabase.auth;

  /// Currently authenticated Supabase user.
  User? get currentUser => _auth.currentUser;

  /// Currently active session.
  Session? get currentSession => _auth.currentSession;

  /// Whether a user is currently authenticated.
  bool get isAuthenticated => currentUser != null;

  // ---------------------------------------------------------------------------
  // Email & Password
  // ---------------------------------------------------------------------------

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _execute(() async {
      final response = await _auth.signUp(email: email, password: password);

      final user = response.user;

      if (user == null) {
        throw CustomException(message: S.current.unexpected_error);
      }

      return user;
    });
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _execute(() async {
      final response = await _auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        throw CustomException(message: S.current.invalid_credentials);
      }

      return user;
    });
  }

  // ---------------------------------------------------------------------------
  // Google
  // ---------------------------------------------------------------------------

  Future<AuthResponse> signInWithGoogle() async {
    return _execute(() async {
      final googleUser = await _googleSignIn.authenticate();

      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw CustomException(message: S.current.unexpected_error);
      }

      final response = await _auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      if (response.user == null) {
        throw CustomException(message: S.current.unexpected_error);
      }

      return response;
    });
  }

  // ---------------------------------------------------------------------------
  // Delete
  // ---------------------------------------------------------------------------

  Future<void> deleteCurrentUser() async {
    return _execute(() async {
      await _auth.admin.deleteUser(currentUser!.id);
      //await _supabase.functions.invoke(
      //   'delete-account',
      // );
    });
  }

  // ---------------------------------------------------------------------------
  // Sign Out
  // ---------------------------------------------------------------------------

  Future<void> signOut() async {
    return _execute(() async {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    });
  }

  // ---------------------------------------------------------------------------
  // Error Handling
  // ---------------------------------------------------------------------------

  Future<T> _execute<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on AuthException catch (e, stackTrace) {
      log(
        'Supabase AuthException: '
        'status=${e.statusCode}, code=${e.code}, message=${e.message}',
        error: e,
        stackTrace: stackTrace,
      );

      throw CustomException(
        message: SupabaseExceptionMapper.mapAuthException(
          code: e.code,
          statusCode: toInt(e.statusCode),
          message: e.message,
        ),
      );
    } on GoogleSignInException catch (e, stackTrace) {
      log('GoogleSignInException: ${e.code}', error: e, stackTrace: stackTrace);

      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw CustomException(message: S.current.google_sign_in_cancelled);
      }

      throw CustomException(message: S.current.unexpected_error);
    } on CustomException {
      rethrow;
    } catch (e, stackTrace) {
      log(
        S.current.unexpected_error_in_supabase_auth,
        error: e,
        stackTrace: stackTrace,
      );

      throw CustomException(message: S.current.unexpected_error);
    }
  }
}
