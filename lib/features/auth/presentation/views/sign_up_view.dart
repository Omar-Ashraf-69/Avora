import 'package:avora/core/funcs/loading_dialoag.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:avora/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_view_body.dart';
import 'package:avora/features/auth/presentation/views/widgets/have_an_account_row_text.dart';
import 'package:avora/features/auth/presentation/views/widgets/sign_up/sign_up_view_body.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
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
          Navigator.pushReplacementNamed(context, AppRoutes.fillYourProfile);
        }
      },
      child: Scaffold(
        body: AuthViewBody(
          title: S.of(context).create_an_account,
          form: Column(
            children: [
              SignUpViewBody(),
              verticalSpace(24),
              HaveAnAccountRowText(
                title: S.of(context).already_have_an_account,
                actionText: S.of(context).login,
                onTap: () {
                  context.pushReplacementNamed(AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
