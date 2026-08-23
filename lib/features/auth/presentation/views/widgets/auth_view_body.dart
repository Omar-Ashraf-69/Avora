import 'package:avora/core/helper/spacing.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_body.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:flutter/material.dart';

class AuthViewBody extends StatelessWidget {
  const AuthViewBody({
    super.key,
    required this.title,
    required this.form,
    this.footer,
  });

  final String title;
  final Widget form;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return AuthScaffoldBodyWidget(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  AuthHeader(title: title),

                  verticalSpace(24),

                  form,
                ],
              ),
            ),
          ),

          ?footer,

          verticalSpace(16),
        ],
      ),
    );
  }
}
