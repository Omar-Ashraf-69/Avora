import 'package:avora/core/themes/padding.dart';
import 'package:flutter/material.dart';

class AuthScaffoldBodyWidget extends StatelessWidget {
  const AuthScaffoldBodyWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.large),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: child,
        ),
      ),
    );
  }
}
