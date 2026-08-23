import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/helper/validators.dart';
import 'package:avora/core/widgets/custom_form_field.dart';
import 'package:avora/core/widgets/custom_pass_form_field.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class LoginTextFieldsSection extends StatelessWidget {
  const LoginTextFieldsSection({
    super.key,
    required this._emailController,
    required this._passwordController,
    required this._emailFocusNode,
    required this._passwordFocusNode,
    this.submit,
  });
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final FocusNode _emailFocusNode;
  final FocusNode _passwordFocusNode;
  final void Function(String)? submit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFormField(
          controller: _emailController,
          focusNode: _emailFocusNode,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          validator: AppValidators.validateEmail,
          hintText: S.of(context).enter_your_email_address,
        ),
        verticalSpace(16),
        CustomPassFormField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          textInputAction: TextInputAction.done,
          validator: AppValidators.validatePassword,
          onFieldSubmitted: (value) => submit,
        ),
      ],
    );
  }
}
