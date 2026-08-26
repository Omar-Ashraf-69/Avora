import 'dart:developer';

import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/supabase_exception_mapper.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  SupabaseAuthService({required this._supabase, required this._googleSignIn});

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

  Future<void> resetPassword({required String email}) async {
    return _execute(() async {
      await _auth.resetPasswordForEmail(email);
    });
  }

  Future<void> updatePassword({required String password}) async {
    return _execute(() async {
      await _auth.updateUser(UserAttributes(password: password));
    });
  }
  // ---------------------------------------------------------------------------
  // Google
  // ---------------------------------------------------------------------------

  Future<AuthResponse> signInWithGoogle() async {
    return _execute(() async {
      final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '';
      final iosClientId = dotenv.env['GOOGLE_IOS_CLIENT_ID'] ?? '';

      final scopes = ['email', 'profile'];

      await _googleSignIn.initialize(
        serverClientId: webClientId,
        clientId: iosClientId,
      );

      final googleUser = await _googleSignIn.attemptLightweightAuthentication();

      if (googleUser == null) {
        throw AuthException('Failed to sign in with Google.');
      }

      final authorization =
          await googleUser.authorizationClient.authorizationForScopes(scopes) ??
          await googleUser.authorizationClient.authorizeScopes(scopes);

      final idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        throw AuthException('No ID Token found.');
      }

      final response = await _auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
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
      // await _auth.admin.deleteUser(currentUser!.id);
      final res = await _supabase.functions.invoke(
        'delete-account',
        method: HttpMethod.post,
        headers: {
          'Authorization': 'Bearer ${_auth.currentSession!.accessToken}',
        },
        body: {},
      );
      log("deleteCurrentUser: ${res.data}");
    });
  }

  // ---------------------------------------------------------------------------
  // Sign Out
  // ---------------------------------------------------------------------------

  Future<void> signOut() async {
    return _execute(() async {
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
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
