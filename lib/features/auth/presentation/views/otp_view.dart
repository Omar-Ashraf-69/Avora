import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/auth/presentation/views/widgets/otp/otp_code_fields.dart';
import 'package:flutter/material.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: AppPadding.small),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text('OTP Code Verification', style: TextStyles.bold23),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.medium),
          child: Column(
            children: [
              const Spacer(flex: 1),
              Text(
                "Code has been sent to +9112*******0",
                style: TextStyles.semiBold19,
              ),
              verticalSpace(32),
              OtpCodeFields(
                onCompleted: (code) {
                  debugPrint(code);
                },
              ),

              verticalSpace(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Resend code in ", style: TextStyles.semiBold16),
                  GestureDetector(
                    onTap: () {
                      // Handle resend code action
                    },
                    child: Text(
                      "00:30",
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.mainBlue,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              CustomButton(label: 'Verify', onPressed: () {}),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
