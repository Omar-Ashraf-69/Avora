
import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/funcs/custom_field_decoration.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/features/groups/presentation/views/widgets/create_group/group_avatar_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GroupInformationSection extends StatelessWidget {
  const GroupInformationSection({super.key, required this.controller, this.onImageSelected});
  final ValueChanged<XFile?>? onImageSelected;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         GroupAvatarPicker(
                    onImageSelected: onImageSelected,

        ),

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
