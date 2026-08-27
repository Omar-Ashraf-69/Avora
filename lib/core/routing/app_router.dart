import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/features/auth/presentation/fortgot_pass_cubit/forgot_pass_cubit.dart';
import 'package:avora/features/auth/presentation/reset_pass_cubit/reset_pass_cubit.dart';
import 'package:avora/features/auth/presentation/sign_up_cubit/sign_up_cubit.dart';
import 'package:avora/features/auth/presentation/views/widgets/forgot_password/forgot_password_view.dart';
import 'package:avora/features/auth/presentation/views/widgets/forgot_password/reset_pass_screen.dart';
import 'package:avora/features/chat/presentation/views/chat_room_view.dart';
import 'package:avora/features/groups/presentation/views/widgets/create_group_view.dart';
import 'package:avora/features/profile/presentation/views/edit_profile_view.dart';
import 'package:avora/features/profile/presentation/views/fill_your_profile_view.dart';
import 'package:avora/features/auth/presentation/views/login_view.dart';
import 'package:avora/features/auth/presentation/views/otp_view.dart';
import 'package:avora/features/auth/presentation/views/sign_up_view.dart';
import 'package:avora/features/home/presentation/views/home_view.dart';
import 'package:avora/features/qr/presentation/views/qr_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return _buildRoute(const LoginView());

      case AppRoutes.signUp:
        return _buildRoute(
          BlocProvider(
            create: (_) => getIt<SignUpCubit>(),
            child: const SignUpView(),
          ),
        );
      case AppRoutes.otp:
        return _buildRoute(const OtpVerificationView());
      case AppRoutes.fillYourProfile:
        return _buildRoute(const FillYourProfileView());
      case AppRoutes.home:
        return _buildRoute(const HomeView());
      case AppRoutes.editProfile:
        return _buildRoute(const EditProfileView());
      case AppRoutes.qrCode:
        return _buildRoute(const QrCodeView());
      case AppRoutes.createGroup:
        return _buildRoute(const CreateGroupView());
      case AppRoutes.chatRoom:
        return _buildRoute(const ChatRoomView(userName: "Andrew Ainsley"));
      case AppRoutes.forgotPassword:
        return _buildRoute(
          BlocProvider(
            create: (context) => getIt<ForgotPassCubit>(),
            child: const ForgotPasswordView(),
          ),
        );

      case AppRoutes.resetPassword:
        return _buildRoute(
          BlocProvider(
            create: (context) => getIt<ResetPassCubit>(),
            child: const ResetPasswordScreen(),
          ),
        );

      //? Unknown Route
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
