import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_app_bar.dart';
import 'package:avora/features/auth/presentation/views/widgets/custom_divider.dart';
import 'package:avora/features/auth/presentation/views/widgets/forgot_password/forgot_password_illstruction.dart';
import 'package:avora/features/auth/presentation/views/widgets/forgot_password/reset_pass_email_field_section.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, S.of(context).forgot_password),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.large),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Illustration
                  const ForgotPasswordIllustration(),
                  verticalSpace(16),
                  // Title
                  Text(
                    S.of(context).forgot_password,
                    textAlign: TextAlign.center,
                    style: TextStyles.bold23,
                  ),
                  verticalSpace(8),
                  // Description
                  Text(
                    S.of(context).no_worries_enter_your_email_address,
                    textAlign: TextAlign.center,
                    style: TextStyles.semiBold16,
                  ),
                  verticalSpace(24),
                  // Email label
                  Text(
                    S.of(context).email_address,
                    style: TextStyles.semiBold16,
                  ),
                  verticalSpace(8),
                  // Email field
                  ResetPassEmailFieldSection(),
                  verticalSpace(24),
                  // Divider
                  CustomDividerWidget(),
                  verticalSpace(24),
                  // Back to login
                  TextButton(
                    child: Text(
                      S.of(context).back_to_login,
                      style: TextStyles.semiBold16,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  verticalSpace(12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
