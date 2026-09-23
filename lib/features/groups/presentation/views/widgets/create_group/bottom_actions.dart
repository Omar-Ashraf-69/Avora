import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomActions extends StatelessWidget {
  const BottomActions({
    super.key,
    required this.onCancel,
    required this.onCreate,
    required this.isLoading,
  });

  final VoidCallback? onCancel;
  final VoidCallback? onCreate;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.medium,
        AppPadding.small,
        AppPadding.medium,
        AppPadding.medium,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: AppColors.lighterGray, width: .7),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              label: 'Cancel',
              onPressed: onCancel,
              color: AppColors.lightRed,
            ),
          ),
          horizontalSpace(AppSpacing.md),

          Expanded(
            child: isLoading
                ? SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: null,
                      child: SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,

                          color: AppColors.mainBlue,
                        ),
                      ),
                    ),
                  )
                : CustomButton(label: 'Create', onPressed: onCreate),
          ),
        ],
      ),
    );
  }
}
