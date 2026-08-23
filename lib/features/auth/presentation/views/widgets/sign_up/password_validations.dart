import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow(
          S.of(context).at_least_1_lowercase_letter,
          hasLowerCase,
        ),
        verticalSpace(2),
        buildValidationRow(
          S.of(context).at_least_1_uppercase_letter,
          hasUpperCase,
        ),
        verticalSpace(2),
        buildValidationRow(
          S.of(context).at_least_1_special_character,
          hasSpecialCharacters,
        ),
        verticalSpace(2),
        buildValidationRow(S.of(context).at_least_1_number, hasNumber),
        verticalSpace(2),
        buildValidationRow(S.of(context).at_least_8_characters, hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        CircleAvatar(radius: 3.r, backgroundColor: AppColors.gray),
        horizontalSpace(8),
        Text(
          text,
          style: TextStyles.regular13.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? AppColors.gray : AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}
