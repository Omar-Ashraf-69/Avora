import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/core/widgets/custom_app_bar.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_body.dart';
import 'package:avora/features/auth/presentation/views/widgets/otp/otp_code_fields.dart';
import 'package:avora/features/auth/presentation/views/widgets/otp/otp_header.dart';
import 'package:avora/features/auth/presentation/views/widgets/otp/otp_resend_section.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, S.of(context).otp_code_verification),
      body: AuthScaffoldBodyWidget(
        child: Column(
          children: [
            OtpHeader(phoneNumber: "+1 23******0"),
            verticalSpace(AppSpacing.xl),
            OtpCodeFields(
              onCompleted: (code) {
                //! Handle OTP code completion
              },
            ),
            verticalSpace(24),
            const OtpResendSection(),
            const Spacer(flex: 2),
            CustomButton(
              label: S.of(context).verify,
              onPressed: () {
                context.pushNamed(AppRoutes.fillYourProfile);
              },
            ),
            verticalSpace(AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
