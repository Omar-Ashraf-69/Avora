import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/features/auth/presentation/views/login_view.dart';
import 'package:avora/features/auth/presentation/views/otp_view.dart';
import 'package:avora/features/auth/presentation/views/sign_up_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return _buildRoute(const LoginView());
      case AppRoutes.signUp:
        return _buildRoute(const SignUpView());
      case AppRoutes.otp:
        return _buildRoute(const OtpVerificationView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  Route<dynamic> _buildRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
