import 'package:avora/core/auth/cubit/session_cubit.dart';
import 'package:avora/core/auth/cubit/session_state.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionNavigationListener extends StatefulWidget {
  const SessionNavigationListener({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<SessionNavigationListener> createState() =>
      _SessionNavigationListenerState();
}

class _SessionNavigationListenerState extends State<SessionNavigationListener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateBasedOnState(context.read<SessionCubit>().state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listenWhen: (previous, current) {
        return previous.runtimeType != current.runtimeType;
      },
      listener: (context, state) {
        _navigateBasedOnState(state);
      },
      child: widget.child,
    );
  }

  void _navigateBasedOnState(SessionState state) {
    final navigator = widget.navigatorKey.currentState;
    if (navigator == null) return;

    if (state is SessionUnauthenticated) {
      navigator.pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    } else if (state is SessionProfileIncomplete) {
      navigator.pushNamedAndRemoveUntil(
        AppRoutes.fillYourProfile,
        (route) => false,
      );
    } else if (state is SessionAuthenticated) {
      navigator.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
    }
  }
}
