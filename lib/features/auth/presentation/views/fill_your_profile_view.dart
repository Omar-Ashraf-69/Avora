import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/funcs/congratulations_dialog.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/widgets/custom_app_bar.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_body.dart';
import 'package:avora/features/auth/presentation/views/widgets/fill_your_profile/profile_avatar_picker.dart';
import 'package:avora/features/auth/presentation/views/widgets/fill_your_profile/profile_fields_section.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class FillYourProfileView extends StatelessWidget {
  const FillYourProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, S.of(context).fill_your_profile),
      body: AuthScaffoldBodyWidget(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            child: Column(
              spacing: AppSpacing.lg,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileAvatarPicker(),
                ProfileFieldsSection(),
                verticalSpace(AppSpacing.md),
                CustomButton(
                  label: S.of(context).con,
                  onPressed: () {
                    //! TODO: Validate profile
                    congratulationsDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
