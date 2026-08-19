
import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BottomActions extends StatelessWidget {
  const BottomActions({super.key, required this.onCancel, required this.onCreate});

  final VoidCallback onCancel;
  final VoidCallback onCreate;

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
            child: CustomButton(label: 'Create', onPressed: onCreate),
          ),
        ],
      ),
    );
  }
}
