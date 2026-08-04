import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

AppBar otpAppBar(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: AppPadding.small),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      title: Text(
        S.of(context).otp_code_verification,
        style: TextStyles.bold23,
      ),
    );
  }