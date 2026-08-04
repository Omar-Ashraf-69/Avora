import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:flutter/material.dart';

class AuthViewBody extends StatelessWidget {
  const AuthViewBody({
    super.key,
    required this.title,
    required this.form,
    required this.footer,
  });

  final String title;
  final Widget form;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.medium,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      AuthHeader(title: title),

                      verticalSpace(24),

                      form,
                    ],
                  ),
                ),
              ),

              footer,

              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}