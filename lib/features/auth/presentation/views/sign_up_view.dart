import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_view_body.dart';
import 'package:avora/features/auth/presentation/views/widgets/custom_phone_number_field.dart';
import 'package:avora/features/auth/presentation/views/widgets/have_an_account_row_text.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthViewBody(
        title: S.of(context).create_an_account,
        form: Column(
          children: [
            const CustomPhoneNumberField(),
            verticalSpace(24),
            CustomButton(
              label: S.of(context).sign_up,
              onPressed: () async {
                // log(
                //   "The Phone number before moving to the otp is : ${context.read<AuthCubit>().phoneNumber}",
                // );
                // await context.read<AuthCubit>().sendOtp(
                //   context.read<AuthCubit>().phoneNumber,
                // );
              },
            ),
          ],
        ),

        footer: HaveAnAccountRowText(
          title: S.of(context).already_have_an_account,
          actionText: S.of(context).login,
          onTap: () {
            context.pushReplacementNamed(AppRoutes.login);
          },
        ),
      ),
    );
    //return Scaffold(
    //   body: BlocListener<AuthCubit, AuthState>(
    //     listener: (context, state) {
    //       if (state is AuthOtpSent) {
    //         context.pushNamed(AppRoutes.otp, arguments: state.phoneNumber);
    //       }

    //       if (state is AuthError) {
    //         // show your custom error UI
    //         log("Error message is : ${state.message}");
    //         ScaffoldMessenger.of(
    //           context,
    //         ).showSnackBar(SnackBar(content: Text(state.message)));
    //       }
    //     },
    //     child: AuthViewBody(
    //       title: S.of(context).create_an_account,
    //       form: Column(
    //         children: [
    //           const CustomPhoneNumberField(),
    //           verticalSpace(24),
    //           CustomButton(
    //             label: S.of(context).sign_up,
    //             onPressed: () async {
    //               // log(
    //               //   "The Phone number before moving to the otp is : ${context.read<AuthCubit>().phoneNumber}",
    //               // );
    //               // await context.read<AuthCubit>().sendOtp(
    //               //   context.read<AuthCubit>().phoneNumber,
    //               // );
    //             },
    //           ),
    //         ],
    //       ),

    //       footer: HaveAnAccountRowText(
    //         title: S.of(context).already_have_an_account,
    //         actionText: S.of(context).login,
    //         onTap: () {
    //           context.pushReplacementNamed(AppRoutes.login);
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }
}
