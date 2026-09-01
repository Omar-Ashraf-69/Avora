import 'package:avora/core/funcs/loading_dialoag.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/features/auth/presentation/sign_up_cubit/sign_up_cubit.dart';
import 'package:avora/features/auth/presentation/sign_up_cubit/sign_up_state.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_view_body.dart';
import 'package:avora/features/auth/presentation/views/widgets/have_an_account_row_text.dart';
import 'package:avora/features/auth/presentation/views/widgets/sign_up/sign_up_view_body.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          loadingDialog(context);
        }
        if (state is SignUpFailure) {
          Navigator.of(context, rootNavigator: true).pop();
          ToastNoContext.showColoredToast(message: state.message);
        }

        if (state is SignUpSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          //context.pushNamedAndRemoveAll(AppRoutes.fillYourProfile);
          //! SessionCubit will receive SIGNED_IN.
        }
      },
      child: SignUpViewBodyListner(),
    );
  }
}

class SignUpViewBodyListner extends StatelessWidget {
  const SignUpViewBodyListner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthViewBody(
        title: S.of(context).create_an_account,
        form: Column(
          children: [
            SignUpViewBody(),
            verticalSpace(24),
            HaveAnAccountRowText(
              title: S.of(context).already_have_an_account,
              actionText: S.of(context).login,
              onTap: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
