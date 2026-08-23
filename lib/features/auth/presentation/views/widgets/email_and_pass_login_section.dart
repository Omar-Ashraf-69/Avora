import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:avora/features/auth/presentation/cubit/auth_state.dart';
import 'package:avora/features/auth/presentation/views/widgets/forgot_pass.dart';
import 'package:avora/features/auth/presentation/views/widgets/login_text_fields_sections.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailAndPassLoginSection extends StatefulWidget {
  const EmailAndPassLoginSection({super.key});

  @override
  State<EmailAndPassLoginSection> createState() =>
      _EmailAndPassLoginSectionState();
}

class _EmailAndPassLoginSectionState extends State<EmailAndPassLoginSection> {
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
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
            AppRoutes.home,
            (route) => false,
          );
        }
      },
      child: Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Column(
          children: [
            LoginTextFieldsSection(
              emailController: _emailController,
              passwordController: _passwordController,
              emailFocusNode: _emailFocusNode,
              passwordFocusNode: _passwordFocusNode,
              submit: (_) => _submit(),
            ),
            verticalSpace(16),
            const ForgetPassWidget(),
            verticalSpace(20),
            CustomButton(label: S.of(context).login, onPressed: _submit),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    context.read<AuthCubit>().signInWithEmail(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }
}
