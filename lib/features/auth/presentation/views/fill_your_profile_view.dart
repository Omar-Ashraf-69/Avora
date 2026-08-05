import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/funcs/congratulations_dialog.dart';
import 'package:avora/core/funcs/custom_field_decoration.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_app_bar.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FillYourProfileView extends StatelessWidget {
  const FillYourProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, S.of(context).fill_your_profile),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.large),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
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
        ),
      ),
    );
  }
}

class ProfileAvatarPicker extends StatelessWidget {
  const ProfileAvatarPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70.sp,
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.person, size: 50, color: AppColors.lightWhite),
        ),
        Positioned(
          bottom: 0,
          right: 14.w,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(AppPadding.extraSmall),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.mainBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.edit, size: 20.h, color: AppColors.lightWhite),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileFieldsSection extends StatelessWidget {
  const ProfileFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: customFieldDecoration(S.of(context).fisrt_name),
        ),
        verticalSpace(AppSpacing.lg),
        TextFormField(
          decoration: customFieldDecoration(S.of(context).nick_name),
        ),
        verticalSpace(AppSpacing.lg),
        TextFormField(
          readOnly: true,
          decoration: customFieldDecoration(
            S.of(context).date_of_birth,
            suffixIcon: Icon(
              Icons.calendar_month_rounded,
              color: AppColors.lightGray,
            ),
          ),
        ),
        verticalSpace(AppSpacing.lg),
        TextFormField(
          decoration: customFieldDecoration(
            S.of(context).email,
            suffixIcon: Icon(Icons.alternate_email, color: AppColors.lightGray),
          ),
        ),
        verticalSpace(AppSpacing.lg),
        TextFormField(decoration: customFieldDecoration(S.of(context).about)),
      ],
    );
  }
}
