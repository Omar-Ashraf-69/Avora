import 'package:avora/core/funcs/custom_form_field_border.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomFormField extends StatelessWidget {
  const CustomFormField({super.key, required this.hintText, required this.controller,required this.validator, this.focusNode, this.textInputAction, this.onFieldSubmitted, this.keyboardType});
  final String hintText;
final TextEditingController controller;
  final Function(String?) validator;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

final ValueChanged<String>? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: (value) {
        return validator(value);
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder: customBorder(),
        enabledBorder: customBorder(),
        errorBorder: customBorder(Colors.red),
        focusedErrorBorder: customBorder(Colors.red),
        hintStyle: TextStyles.bold13.copyWith(color: AppColors.lightGray),
        hintText: hintText,
        fillColor: AppColors.moreLightGray,
        filled: true,
      ),
      style: TextStyles.bold13,
    );
  }

}
