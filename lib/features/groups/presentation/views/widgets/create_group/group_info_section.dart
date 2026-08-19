
import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/funcs/custom_field_decoration.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/features/groups/presentation/views/widgets/create_group/group_avatar_picker.dart';
import 'package:flutter/material.dart';

class GroupInformationSection extends StatelessWidget {
  const GroupInformationSection({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const GroupAvatarPicker(),

        horizontalSpace(AppSpacing.md),

        Expanded(
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.done,
            decoration: customFieldDecoration('Group name'),
          ),
        ),
      ],
    );
  }
}
