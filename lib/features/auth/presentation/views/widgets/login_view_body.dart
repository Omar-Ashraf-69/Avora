import 'package:avora/core/constants/assets.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/auth/presentation/login_cubit/login_cubit.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:avora/features/auth/presentation/views/widgets/custom_divider.dart';
import 'package:avora/features/auth/presentation/views/widgets/email_and_pass_login_section.dart';
import 'package:avora/features/auth/presentation/views/widgets/have_an_account_row_text.dart';
import 'package:avora/features/auth/presentation/views/widgets/sign_in_with_social_button.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.large),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                AuthHeader(title: S.of(context).login_into_your_account),
                verticalSpace(16),
                EmailAndPassLoginSection(),
                verticalSpace(16),
                HaveAnAccountRowText(
                  title: S.of(context).dont_have_an_account,
                  actionText: S.of(context).sign_up,
                  onTap: () {
                    context.pushNamed(AppRoutes.signUp);
                  },
                ),
                verticalSpace(24),
                const CustomDividerWidget(),
                verticalSpace(28),
                SignButtonWidget(
                  onPressed: () async {
                    await context.read<LoginCubit>().signInWithGoogle();
                  },
                  icon: Assets.imagesSvgsGoogleIcon,
                  buttonLabel: S.of(context).login_with_google,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
