import 'package:avora/core/auth/cubit/session_cubit.dart';
import 'package:avora/core/auth/cubit/session_state.dart';
import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/auth/presentation/login_cubit/login_cubit.dart';
import 'package:avora/features/auth/presentation/views/login_view.dart';
import 'package:avora/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStartView extends StatelessWidget {
  const AppStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        switch (state) {
          case SessionInitial():
          case SessionLoading():
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          case SessionUnauthenticated():
            return BlocProvider(
              create: (_) => getIt<LoginCubit>(),
              child: const LoginView(),
            );

          case SessionAuthenticated():
            return const HomeView();
        }
      },
    );
  }
}
