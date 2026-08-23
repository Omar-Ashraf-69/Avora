
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/auth/presentation/views/widgets/login_logo.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.large),
      child: Column(
        children: [
          const LoginLogo(),
          verticalSpace(20),
          Text(title, style: TextStyles.bold23),
        ],
      ),
    );
  }
}
