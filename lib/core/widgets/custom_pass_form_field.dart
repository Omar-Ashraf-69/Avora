import 'package:avora/core/funcs/custom_form_field_border.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPassFormField extends StatefulWidget {
  const CustomPassFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });
  final TextEditingController controller;
  final Function(String?) validator;

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<CustomPassFormField> createState() => _CustomPassFormFieldState();
}

class _CustomPassFormFieldState extends State<CustomPassFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,

      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: (value) => widget.validator(value),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder: customBorder(),
        enabledBorder: customBorder(),
        errorBorder: customBorder(Colors.red),
        focusedErrorBorder: customBorder(Colors.red),
        hintStyle: TextStyles.bold13.copyWith(color: AppColors.lightGray),
        hintText: S.of(context).enter_your_password,
        fillColor: AppColors.moreLightGray,

        filled: true,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Icon(
              obscureText ? Icons.visibility_off : Icons.remove_red_eye,
              color: AppColors.lightGray,
            ),
          ),
        ),
      ),
      style: TextStyles.bold13,
    );
  }
}
