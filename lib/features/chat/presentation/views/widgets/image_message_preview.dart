import 'dart:io';

import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageMessagePreview extends StatelessWidget {
  const ImageMessagePreview({
    super.key,
    required this.imageFile,
    required this.isUploading,
    required this.onSend,
    required this.onRemove,
  });

  final File imageFile;
  final bool isUploading;
  final VoidCallback onSend;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        12.w,
        8.h,
        12.w,
        4.h,
      ),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.lightWhite,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          _buildImagePreview(),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              isUploading ? 'Sending image...' : 'Image',
              style: TextStyles.regular13,
            ),
          ),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.file(
        imageFile,
        width: 64.w,
        height: 64.h,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildActionButton() {
    if (isUploading) {
      return SizedBox(
        width: 42.w,
        height: 42.h,
        child: Padding(
          padding: EdgeInsets.all(11.w),
          child: CircularProgressIndicator(
            strokeWidth: 2.5.w,
            color: AppColors.mainBlue,
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.close),
          color: AppColors.gray,
        ),
        IconButton(
          onPressed: onSend,
          icon: const Icon(Icons.send_rounded),
          color: AppColors.mainBlue,
        ),
      ],
    );
  }
}