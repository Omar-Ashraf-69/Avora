import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/funcs/custom_field_decoration.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/features/auth/presentation/views/widgets/custom_phone_number_field.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class ProfileFieldsSection extends StatelessWidget {
  const ProfileFieldsSection({super.key, required this.nameController, required this.usernameController, required this.phoneController, required this.emailController, required this.aboutController});


  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController aboutController;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      children: [
        TextFormField(
          controller: nameController,
          decoration: customFieldDecoration(S.of(context).name)),
        TextFormField(
          controller: usernameController,
          decoration: customFieldDecoration(S.of(context).user_name),
        ),
        CustomPhoneNumberField(
          controller: phoneController,
        ),
        // TextFormField(
        //   decoration: customFieldDecoration(
        //     S.of(context).phone_number,
        //     suffixIcon: Icon(
        //       Icons.calendar_month_rounded,
        //       color: AppColors.lightGray,
        //     ),
        //   ),
        // ),
        TextFormField(
          controller: emailController,
          readOnly: true,
          decoration: customFieldDecoration(
            S.of(context).email,
            suffixIcon: Icon(Icons.alternate_email, color: AppColors.lightGray),
          ),
        ),
        TextFormField(
          controller: aboutController,
          maxLines: 3,
          decoration: customFieldDecoration(S.of(context).about)),
      ],
    );
  }
}
