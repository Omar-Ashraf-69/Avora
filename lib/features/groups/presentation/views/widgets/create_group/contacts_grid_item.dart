
import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/features/groups/data/models/group_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class ContactGridItem extends StatelessWidget {
  const ContactGridItem({super.key, 
    required this.contact,
    required this.isSelected,
    required this.onTap,
  });

  final GroupContact contact;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(isSelected ? 3.r : 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: AppColors.mainBlue, width: 2)
                      : null,
                ),
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColors.lighterGray,
                  backgroundImage: contact.imageUrl.isNotEmpty
                      ? NetworkImage(contact.imageUrl)
                      : null,
                  child: contact.imageUrl.isEmpty
                      ? HugeIcon(
                          icon: HugeIcons.strokeRoundedUser,
                          size: 28.sp,
                          color: AppColors.gray,
                        )
                      : null,
                ),
              ),

              if (isSelected)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(3.r),
                    decoration: const BoxDecoration(
                      color: AppColors.mainBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 14.sp,
                      color: AppColors.lightWhite,
                    ),
                  ),
                ),
            ],
          ),

          verticalSpace(AppSpacing.xs),

          Text(
            contact.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.semiBold13,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
