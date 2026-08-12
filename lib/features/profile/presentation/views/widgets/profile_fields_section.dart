import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/funcs/custom_field_decoration.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class ProfileFieldsSection extends StatelessWidget {
  const ProfileFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      children: [
        TextFormField(
          decoration: customFieldDecoration(S.of(context).fisrt_name),
        ),
        TextFormField(
          decoration: customFieldDecoration(S.of(context).nick_name),
        ),
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
        TextFormField(
          decoration: customFieldDecoration(
            S.of(context).email,
            suffixIcon: Icon(Icons.alternate_email, color: AppColors.lightGray),
          ),
        ),
        TextFormField(decoration: customFieldDecoration(S.of(context).about)),
      ],
    );
  }
}
