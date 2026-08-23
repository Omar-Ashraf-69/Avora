import 'package:avora/core/helper/app_regex.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/widgets/app_text_form_field.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:avora/features/auth/presentation/cubit/auth_state.dart';
import 'package:avora/features/auth/presentation/views/widgets/sign_up/password_validations.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingUpFormSection extends StatefulWidget {
  const SingUpFormSection({super.key});
  @override
  State<SingUpFormSection> createState() => _SingUpFormSectionState();
}

class _SingUpFormSectionState extends State<SingUpFormSection> {
  bool isObscureText = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late TextEditingController emailController;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailController = TextEditingController();
    setupPasswordControllerListener();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          passwordController.text,
        );
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ToastNoContext.showColoredToast(message: state.message);
        }

        if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.fillYourProfile,
            (route) => false,
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextFormField(
              hintText: S.of(context).email,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !AppRegex.isEmailValid(value)) {
                  return S.of(context).please_enter_a_valid_email;
                }
              },
              controller: emailController,
            ),
            verticalSpace(12),
            AppTextFormField(
              controller: passwordController,
              hintText: S.of(context).password,
              isObscureText: isObscureText,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                child: Icon(
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_enter_a_valid_password;
                }
              },
            ),
            verticalSpace(12),
            AppTextFormField(
              controller: confirmPasswordController,
              hintText: S.of(context).confirm_password,
              isObscureText: isObscureText,

              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                child: Icon(
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value != passwordController.text) {
                  setState(() {});
                  return S.of(context).passwords_do_not_match;
                }
              },
            ),
            verticalSpace(16),
            PasswordValidations(
              hasLowerCase: hasLowercase,
              hasUpperCase: hasUppercase,
              hasSpecialCharacters: hasSpecialCharacters,
              hasNumber: hasNumber,
              hasMinLength: hasMinLength,
            ),
            verticalSpace(16),
            CustomButton(
              label: S.of(context).sign_up,
              onPressed: () {
                validateThenDoSingUp(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void validateThenDoSingUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUpNewUser(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }
}
