import 'package:avora/core/funcs/loading_dialoag.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/features/auth/presentation/login_cubit/login_cubit.dart';
import 'package:avora/features/auth/presentation/login_cubit/login_state.dart';
import 'package:avora/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          loadingDialog(context);
        }
        if (state is LoginFailure) {
          // Show error
          Navigator.of(context, rootNavigator: true).pop();
          ToastNoContext.showColoredToast(message: state.message);
        }

        if (state is LoginSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          // SessionCubit will receive Supabase's signedIn event.
        }
      },
      child: LoginViewBody(),
    );
  }
}
