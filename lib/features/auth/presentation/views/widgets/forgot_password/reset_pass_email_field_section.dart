import 'dart:developer';

import 'package:avora/core/funcs/custom_form_field_border.dart';
import 'package:avora/core/funcs/loading_dialoag.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/helper/validators.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/features/auth/presentation/fortgot_pass_cubit/forgot_pass_cubit.dart';
import 'package:avora/features/auth/presentation/fortgot_pass_cubit/forgot_pass_state.dart';
import 'package:avora/features/auth/presentation/views/widgets/forgot_password/gradiant_button.dart';
import 'package:avora/features/auth/presentation/views/widgets/forgot_password/info_card.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassEmailFieldSection extends StatefulWidget {
  const ResetPassEmailFieldSection({super.key});

  @override
  State<ResetPassEmailFieldSection> createState() =>
      _ResetPassEmailFieldSectionState();
}

class _ResetPassEmailFieldSectionState
    extends State<ResetPassEmailFieldSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });

    //? TODO: SupaBase integration
    // await Future.delayed(const Duration(seconds: 2));
    context.read<ForgotPassCubit>().sendResetEmail(
      email: _emailController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPassCubit, ForgotPassState>(
      listener: (context, state) {
        if (state is ForgotPassLoading) {
          loadingDialog(context);
        }
        if (state is ForgotPassSuccess) {
          log("Have sent the url ");
          context.pop();
          ToastNoContext.showColoredToast(
            message: S.of(context).password_reset_link_sent_successfully,
          );
          context.pushNamed(AppRoutes.resetPassword);
        }
        if (state is ForgotPassFailure) {
          log("Have not sent the url ");
          context.pop();
          ToastNoContext.showColoredToast(message: state.message);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.email],
                onFieldSubmitted: (_) => _sendResetLink(),
                style: TextStyles.semiBold13,
                decoration: InputDecoration(
                  hintText: S.of(context).enter_your_email_address,
                  hintStyle: TextStyles.semiBold13.copyWith(
                    color: AppColors.lightGray,
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 24.r,
                    color: AppColors.mainBlue,
                  ),
                  filled: true,
                  fillColor: AppColors.moreLightGray,
                  border: customBorder(),
                  enabledBorder: customBorder(),
                  focusedBorder: customBorder(),
                  errorBorder: customBorder(Colors.red),
                  focusedErrorBorder: customBorder(Colors.red),
                ),
                validator: (value) => AppValidators.validateEmail(value),
              ),

              verticalSpace(24),

              // Information card
              const InfoCard(),

              verticalSpace(32),

              // Send button
              GradientButton(isLoading: _isLoading, onPressed: _sendResetLink),
            ],
          ),
        );
      },
    );
  }
}
