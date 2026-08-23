import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_view_body.dart';
import 'package:avora/features/auth/presentation/views/widgets/custom_phone_number_field.dart';
import 'package:avora/features/auth/presentation/views/widgets/have_an_account_row_text.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  final String phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthViewBody(
        title: S.of(context).login_into_your_account,
        form: Column(
          children: [
            const CustomPhoneNumberField(),
            verticalSpace(24),
            CustomButton(
              label: S.of(context).login,
              onPressed: () {
                context.pushNamed(AppRoutes.otp);
              },
            ),
          ],
        ),
        footer: HaveAnAccountRowText(
          title: S.of(context).dont_have_an_account,
          actionText: S.of(context).sign_up,
          onTap: () {
            context.pushReplacementNamed(AppRoutes.signUp);
          },
        ),
      ),
    );
  }
}
