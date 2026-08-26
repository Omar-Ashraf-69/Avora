import 'package:avora/core/funcs/loading_dialoag.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:avora/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:avora/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          loadingDialog(context);
        } else if (state is AuthError) {
          Navigator.of(context, rootNavigator: true).pop();
          ToastNoContext.showColoredToast(message: state.message);
        } else if (state is Authenticated) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      },
      child: LoginViewBody(),
    );
  }
}
