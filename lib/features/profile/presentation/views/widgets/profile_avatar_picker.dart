import 'dart:io';

import 'package:avora/core/funcs/pick_image.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatarPicker extends StatefulWidget {
  const ProfileAvatarPicker({super.key, required this.onImageSelected});
  final ValueChanged<XFile?> onImageSelected;
  @override
  State<ProfileAvatarPicker> createState() => _ProfileAvatarPickerState();
}

class _ProfileAvatarPickerState extends State<ProfileAvatarPicker> {
  XFile? _selectedImage;
  @override
  Widget build(BuildContext context) {
    final hasImage = _selectedImage != null;
    return Stack(
      children: [
        CircleAvatar(
          radius: 70.sp,
          backgroundColor: Colors.grey[300],
          backgroundImage: _selectedImage != null
              ? FileImage(File(_selectedImage!.path))
              : null,
          child: !hasImage
              ? Icon(Icons.person, size: 50, color: AppColors.lightWhite)
              : null,
        ),
        // Edit button
        Positioned(
          bottom: 0,
          right: hasImage ? 44.w : 12.w,
          child: _buildActionButton(
            icon: Icons.edit,
            onTap: () => _pickImage(context),
          ),
        ), // Remove button
        if (hasImage)
          Positioned(
            bottom: 0,
            right: 12.w,
            child: _buildActionButton(
              icon: Icons.delete_outline,
              onTap: _removeImage,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.extraSmall),
        decoration: BoxDecoration(
          color: icon == Icons.delete_outline
              ? AppColors.lightRed
              : AppColors.mainBlue,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 20.h, color: AppColors.lightWhite),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final image = await pickImage(context);
    if (image == null) return;
    setState(() {
      _selectedImage = image;
    });
    widget.onImageSelected(image);
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
    widget.onImageSelected(null);
  }
}
