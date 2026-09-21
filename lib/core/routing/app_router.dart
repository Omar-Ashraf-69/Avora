import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/widgets/custom_loading_indecator.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/auth/presentation/fortgot_pass_cubit/forgot_pass_cubit.dart';
import 'package:avora/features/auth/presentation/login_cubit/login_cubit.dart';
import 'package:avora/features/auth/presentation/reset_pass_cubit/reset_pass_cubit.dart';
import 'package:avora/features/auth/presentation/sign_up_cubit/sign_up_cubit.dart';
import 'package:avora/features/auth/presentation/views/login_view.dart';
import 'package:avora/features/auth/presentation/views/otp_view.dart';
import 'package:avora/features/auth/presentation/views/sign_up_view.dart';
import 'package:avora/features/auth/presentation/views/widgets/forgot_password/forgot_password_view.dart';
import 'package:avora/features/auth/presentation/views/widgets/forgot_password/reset_pass_screen.dart';
import 'package:avora/features/chat/presentation/views/chat_room_view.dart';
import 'package:avora/features/chats/presentation/cubits/chat_cubit/chat_cubit.dart';
import 'package:avora/features/chats/presentation/cubits/chats_cubit/chats_cubit.dart';
import 'package:avora/features/chats/presentation/cubits/conversation_cubit/conversation_cubit.dart';
import 'package:avora/features/chats/presentation/cubits/group_chat_cubit/group_chat_cubit.dart';
import 'package:avora/features/chats/presentation/cubits/presence_cubit/presence_cubit.dart';
import 'package:avora/features/group_chat/presentation/views/group_chat_room.dart';
import 'package:avora/features/groups/presentation/cubits/create_group/create_group_cubit.dart';
import 'package:avora/features/groups/presentation/cubits/groups_cubit/groups_cubit.dart';
import 'package:avora/features/groups/presentation/views/widgets/create_group_view.dart';
import 'package:avora/features/home/presentation/views/cubits/message_delivery_cubit.dart';
import 'package:avora/features/home/presentation/views/home_view.dart';
import 'package:avora/features/profile/presentation/cubits/fill_your_profile/fill_your_profile_cubit.dart';
import 'package:avora/features/profile/presentation/views/edit_profile_view.dart';
import 'package:avora/features/profile/presentation/views/fill_your_profile_view.dart';
import 'package:avora/features/qr/presentation/views/qr_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(const SplashView());

      case AppRoutes.login:
        return _buildRoute(
          BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginView(),
          ),
        );

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
        return _buildRoute(
          BlocProvider(
            create: (_) => getIt<ProfileCubit>(),
            child: const FillYourProfileView(),
          ),
        );

      case AppRoutes.home:
        return _buildRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<GroupsCubit>()),
              BlocProvider(create: (_) => getIt<ConversationCubit>()),
              BlocProvider(
                lazy: false,
                create: (_) {
                  final cubit = getIt<MessageDeliveryCubit>();
                  cubit.startListening();
                  return cubit;
                },
              ),
              BlocProvider(
                create: (context) {
                  final cubit = getIt<ChatsCubit>();
                  cubit.loadConversations();
                  cubit.subscribeToConversationUpdates();
                  return cubit;
                },
              ),
              BlocProvider(
                lazy: false,
                create: (_) {
                  final cubit = getIt<PresenceCubit>();
                  final currentUserId = getIt<AuthRepository>()
                      .getCurrentUser()!
                      .id;
                  cubit.startListening(currentUserId: currentUserId);
                  return cubit;
                },
              ),
            ],
            child: const HomeView(),
          ),
        );

      case AppRoutes.editProfile:
        return _buildRoute(const EditProfileView());

      case AppRoutes.qrCode:
        return _buildRoute(const QrCodeView());

      case AppRoutes.createGroup:
        return _buildRoute(
          BlocProvider(
            create: (_) => getIt<CreateGroupCubit>(),
            child: const CreateGroupView(),
          ),
        );

      case AppRoutes.chatRoom:
        final arguments = settings.arguments as Map<String, dynamic>;

        final conversationId = arguments['conversationId'] as String;
        final presenceCubit = arguments['presenceCubit'] as PresenceCubit;
        return _buildRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: presenceCubit),
              BlocProvider(create: (_) => getIt<ChatCubit>()),
            ],
            child: ChatRoomView(conversationId: conversationId),
          ),
        );
      case AppRoutes.groupChatRoom:
        final arguments = settings.arguments as Map<String, dynamic>;

        final conversationId = arguments['conversationId'] as String;

        return _buildRoute(
          BlocProvider(
            create: (_) => getIt<GroupChatCubit>(),
            child: GroupChatRoom(conversationId: conversationId),
          ),
        );
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

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomLoadingIndecator());
  }
}
