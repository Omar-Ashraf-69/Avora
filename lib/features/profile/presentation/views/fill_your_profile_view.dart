import 'package:avora/core/auth/cubit/session_cubit.dart';
import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/funcs/congratulations_dialog.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/auth/presentation/views/widgets/auth_body.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:avora/features/profile/presentation/cubits/fill_your_profile/fill_your_profile_cubit.dart';
import 'package:avora/features/profile/presentation/cubits/fill_your_profile/fill_your_profile_states.dart';
import 'package:avora/features/profile/presentation/views/widgets/profile_avatar_picker.dart';
import 'package:avora/features/profile/presentation/views/widgets/profile_fields_section.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FillYourProfileView extends StatefulWidget {
  const FillYourProfileView({super.key});

  @override
  State<FillYourProfileView> createState() => _FillYourProfileViewState();
}

class _FillYourProfileViewState extends State<FillYourProfileView> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late final TextEditingController nameController;
  late final TextEditingController usernameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController aboutController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    aboutController = TextEditingController();
    _loadCurrentUserEmail();
  }

  void _loadCurrentUserEmail() {
    final user = getIt<AuthRepository>().getCurrentUser();

    if (user != null) {
      emailController.text = user.email ?? '';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    aboutController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileCreated) {
          congratulationsDialog(context);

          context.read<SessionCubit>().startProfileCompletion();
        }

        if (state is ProfileFailure) {
          ToastNoContext.showColoredToast(message: state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(
            S.of(context).fill_your_profile,
            style: TextStyles.bold23,
          ),
        ),
        body: AuthScaffoldBodyWidget(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                spacing: AppSpacing.lg,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileAvatarPicker(),
                  ProfileFieldsSection(
                    nameController: nameController,
                    usernameController: usernameController,
                    phoneController: phoneController,
                    emailController: emailController,
                    aboutController: aboutController,
                  ),
                  verticalSpace(AppSpacing.md),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      final isLoading = state is ProfileLoading;
                      return CustomButton(
                        label: isLoading
                            ? S.of(context).loading
                            : S.of(context).con,
                        onPressed: isLoading ? null : _submitProfile,
                      );
                    },
                  ),
                  verticalSpace(AppSpacing.xs),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitProfile() {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }

    final currentUser = getIt<AuthRepository>().getCurrentUser();

    if (currentUser == null) {
      return;
    }

    final now = DateTime.now();

    final profile = ProfileEntity(
      id: currentUser.id,
      name: nameController.text.trim(),
      username: usernameController.text.trim().toLowerCase(),
      phoneNumber: phoneController.text.trim(),
      email: emailController.text.trim().toLowerCase(),
      about: aboutController.text.trim().isEmpty
          ? null
          : aboutController.text.trim(),
      avatarUrl: null,
      createdAt: now,
      updatedAt: now,
    );

    context.read<ProfileCubit>().createProfile(profile: profile);
  }
}
