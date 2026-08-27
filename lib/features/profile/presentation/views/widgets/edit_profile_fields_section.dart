import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/features/profile/presentation/views/widgets/edit_profile_text_field_decoration.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class EditProfileFieldsSection extends StatelessWidget {
  const EditProfileFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      children: [
        TextFormField(
          initialValue: 'Evin',
          decoration: editProfileTextFieldDecoration(
            context,
            S.of(context).user_name,
            S.of(context).user_name,
          ),
        ),

        TextFormField(
          initialValue: '+1 (123) 456-7890',
          readOnly: true,
          decoration: editProfileTextFieldDecoration(
            context,
            S.of(context).phone_number,
            S.of(context).phone_number,
            true,
          ),
        ),

        TextFormField(
          initialValue: 'Oben St. 10, New York, NY, 10001, USA',
          maxLines: 3,
          minLines: 1,
          decoration: editProfileTextFieldDecoration(
            context,
            S.of(context).bio,
            S.of(context).bio,
          ),
        ),
      ],
    );
  }
}
