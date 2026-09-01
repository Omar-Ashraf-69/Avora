import 'package:avora/core/funcs/custom_field_decoration.dart';
import 'package:avora/core/funcs/phone_formater.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// ignore: must_be_immutable
class CustomPhoneNumberField extends StatelessWidget {
  const CustomPhoneNumberField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      textFieldController: controller,
      onInputChanged: (PhoneNumber number) {},
      onFieldSubmitted: (String value) {},
      onSubmit: () {},
      onInputValidated: (bool value) {},
      textStyle: TextStyles.semiBold16,
      // inputDecoration: InputDecoration(
      //   hintText: S.of(context).enter_your_phone_number,
      //   hintStyle: TextStyles.semiBold13.copyWith(color: AppColors.lightGray),
      //   filled: true,
      //   fillColor: AppColors.lighterGray,
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(24),
      //     borderSide: BorderSide.none,
      //   ),
      // ),
      inputDecoration: customFieldDecoration(S.of(context).phone_number),

      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DIALOG,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 24,
        trailingSpace: false,
        useEmoji: false,
        showFlags: true,
      ),
      ignoreBlank: false,
      countries: ['EG'],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return S.of(context).phoneRequired;
        }

        if (!PhoneNumberFormatter.isValidEgyptianPhone(value)) {
          return S.of(context).invalidPhone;
        }
        return null;
      },
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: TextStyle(color: Colors.black),
      initialValue: PhoneNumber(isoCode: 'EG'),
      formatInput: false,
      keyboardType: TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      inputBorder: OutlineInputBorder(),
      onSaved: (PhoneNumber number) {},
    );
  }
}
