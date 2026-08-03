import 'package:avora/core/constants/assets.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.medium),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.18),
                LoginLogoWidget(),
                SizedBox(height: size.height * 0.1),
                Text(
                  S.of(context).login_into_your_account,
                  style: TextStyles.bold23,
                ),
                verticalSpace(32),
                CustomPhoneNumberField(),
                verticalSpace(32),
                CustomButton(),
                SizedBox(height: size.height * 0.18),
                HaveAnAccountRowText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HaveAnAccountRowText extends StatelessWidget {
  const HaveAnAccountRowText({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).dont_have_an_account,
          style: TextStyles.semiBold16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.small,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Text(
              S.of(context).sign_up,
              style: TextStyles.bold16.copyWith(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          iconColor: Colors.blue,
          backgroundColor: Colors.blue,
          enableFeedback: false,
    
          elevation: 0.0,
          foregroundColor: Colors.white,
        ),
    
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.normal,
          ),
          child: Text(
            S.of(context).login,
            style: TextStyles.bold16,
          ),
        ),
      ),
    );
  }
}

class CustomPhoneNumberField extends StatelessWidget {
  const CustomPhoneNumberField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {},
      onInputValidated: (bool value) {},
      textStyle: TextStyles.semiBold16,
      inputDecoration: InputDecoration(
        hintText: S.of(context).enter_your_phone_number,
        hintStyle: TextStyles.semiBold13.copyWith(
          color: AppColors.lightGray,
        ),
        filled: true,
        fillColor: AppColors.lighterGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DIALOG,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 24,
        trailingSpace: false,
        useEmoji: false,
      ),
      ignoreBlank: false,
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

class LoginLogoWidget extends StatelessWidget {
  const LoginLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesPngsSplash,
      width: 120.w,
      height: 120.h,
    );
  }
}
