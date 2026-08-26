import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:app_links/app_links.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDeepLinkService {
  AuthDeepLinkService({
    required this.onPasswordRecovery,
  });

  final VoidCallback onPasswordRecovery;

  final AppLinks _appLinks = AppLinks();

  StreamSubscription<Uri>? _linkSubscription;
  StreamSubscription<AuthState>? _authSubscription;

  Future<void> initialize() async {
    _listenToAuthChanges();
    _listenToDeepLinks();
  }

  void _listenToAuthChanges() {
    _authSubscription = Supabase
        .instance
        .client
        .auth
        .onAuthStateChange
        .listen(
      (data) {
        log(
          'Auth event: ${data.event}',
        );

        if (data.event ==
            AuthChangeEvent.passwordRecovery) {
          onPasswordRecovery();
        }
      },
      onError: (error, stackTrace) {
        log(
          'AuthDeepLinkService.auth',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }

  void _listenToDeepLinks() {
    _linkSubscription =
        _appLinks.uriLinkStream.listen(
      (uri) {
        log(
          'Deep link received: $uri',
        );
      },
      onError: (error, stackTrace) {
        log(
          'AuthDeepLinkService.deepLink',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }

  Future<void> dispose() async {
    await _linkSubscription?.cancel();
    await _authSubscription?.cancel();
  }
}