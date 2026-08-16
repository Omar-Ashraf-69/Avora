import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/constants/assets.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/chats/presentation/views/widgets/new_chat_bottom_sheet.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class WelcomeViewColumn extends StatelessWidget {
  const WelcomeViewColumn({
    super.key,
    required this.actionText,
    required this.message,
  });
  final String actionText;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesPngsSplashImage,
              width: MediaQuery.of(context).size.width * .7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Text(
                "${S.of(context).welcome} 👋",
                style: TextStyles.bold32.copyWith(color: AppColors.mainBlue),
              ),
            ),
            Text(
              message,
              style: TextStyles.regular15,
              textAlign: TextAlign.center,
            ),
            verticalSpace(AppSpacing.md),
            CustomButton(
              label: actionText,
              onPressed: () async {
                await showNewChatBottomSheet(
                  context,
                  onStartChat: (phoneNumber) {
                    //! TODO: Find user by phone number.
                    //! TODO: Navigate to ChatRoomView.
                    debugPrint('Start chat with: $phoneNumber');
                  },
                );
              },
            ),
            verticalSpace(AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
