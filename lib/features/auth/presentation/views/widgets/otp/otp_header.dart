import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class OtpHeader extends StatelessWidget {
  const OtpHeader({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Spacer(),
          Text(
            "${S.of(context).code_has_been_sent_to} $phoneNumber",
            style: TextStyles.semiBold19,
          ),
        ],
      ),
    );
  }
}
