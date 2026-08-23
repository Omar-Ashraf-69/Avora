import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class ForgetPassWidget extends StatelessWidget {
  const ForgetPassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerEnd,
      child: GestureDetector(
        onTap: () {
          context.pushNamed(AppRoutes.forgotPassword);
        },
        child: Text(
          S.of(context).forgot_password,
          style: TextStyles.semiBold11.copyWith(color: AppColors.mainBlue),
        ),
      ),
    );
  }
}
