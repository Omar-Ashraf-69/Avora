import 'package:avora/core/constants/app_durations.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/auth/presentation/views/widgets/custom_phone_number_field.dart';
import 'package:avora/features/auth/presentation/views/widgets/have_an_account_row_text.dart';
import 'package:avora/features/auth/presentation/views/widgets/login_logo.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = context.isKeyboardOpen;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.medium),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: [
                        /// Header
                        AnimatedPadding(
                          duration: AppDurations.fast,
                          curve: Curves.easeOutCubic,
                          padding: EdgeInsets.only(
                            top: isKeyboardOpen ? 40.h : 190.h,
                          ),
                          child: Column(
                            children: [
                              AnimatedScale(
                                duration: AppDurations.fast,
                                curve: Curves.easeOutCubic,
                                scale: isKeyboardOpen ? .65 : 1,
                                child: const LoginLogo(),
                              ),

                              SizedBox(height: isKeyboardOpen ? 24.h : 56.h),

                              AnimatedOpacity(
                                duration: AppDurations.fast,
                                opacity: isKeyboardOpen ? .7 : 1,
                                child: Text(
                                  S.of(context).login_into_your_account,
                                  style: TextStyles.bold23,
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(24),
                        const CustomPhoneNumberField(),
                        verticalSpace(24),
                        CustomButton(
                          label: S.of(context).login,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                HaveAnAccountRowText(
                  title: S.of(context).dont_have_an_account,
                  actionText: S.of(context).sign_up,
                  onTap: () {
                    context.pushReplacementNamed(AppRoutes.signUp);
                  },
                ),

                verticalSpace(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
