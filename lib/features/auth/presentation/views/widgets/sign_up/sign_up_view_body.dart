import 'package:avora/core/helper/spacing.dart';
import 'package:avora/features/auth/presentation/views/widgets/sign_up/sign_up_form_section.dart';
import 'package:avora/features/auth/presentation/views/widgets/sign_up/terms_and_conditions_text.dart';
import 'package:flutter/material.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingUpFormSection(),
        verticalSpace(16),
        TermsAndConditionsText(),
        verticalSpace(20),
      ],
    );
  }
}
