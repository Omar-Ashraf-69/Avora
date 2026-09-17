import 'dart:developer';

import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter/widgets.dart';

import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/profile/domain/use_cases/update_last_seen_use_case.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  AppLifecycleObserver();

  final UpdateLastSeenUseCase updateLastSeenUseCase =
      getIt<UpdateLastSeenUseCase>();

  bool _isInBackground = false;

  @override
  void didChangeAppLifecycleState(
    AppLifecycleState state,
  ) {
    switch (state) {
      case AppLifecycleState.resumed:
        _handleResumed();
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _handleBackground();
        break;

      case AppLifecycleState.hidden:
        _handleBackground();
        break;
    }
  }

  void _handleResumed() {
    _isInBackground = false;
  }

 void _handleBackground() {
  if (_isInBackground) return;

  _isInBackground = true;

  final currentUser = getIt<AuthRepository>().getCurrentUser();

  if (currentUser == null) {
    return;
  }

  final lastSeenAt = DateTime.now().toUtc();

  log(
    'Updating last seen: $lastSeenAt',
  );

  updateLastSeenUseCase(
    lastSeenAt: lastSeenAt,
  );
}
}