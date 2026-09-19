import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/widgets/images/app_cached_image.dart';
import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    required this.radius,
    this.fallbackIcon,
    this.placeholder,
  });

  final String? imageUrl;
  final double radius;
  final Widget? fallbackIcon;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        imageUrl != null && imageUrl!.trim().isNotEmpty;

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.lightGray,
      child: ClipOval(
        child: hasImage
            ? AppCachedImage(
                imageUrl: imageUrl,
                width: radius * 2,
                height: radius * 2,
                placeholder: (_, _) =>
                    placeholder ?? const SizedBox.shrink(),
                errorWidget: (_, _, _) =>
                    fallbackIcon ??
                    Icon(
                      Icons.person,
                      size: radius,
                      color: AppColors.lightWhite,
                    ),
              )
            : fallbackIcon ??
                Icon(
                  Icons.person,
                  size: radius,
                  color: AppColors.lightWhite,
                ),
      ),
    );
  }
}