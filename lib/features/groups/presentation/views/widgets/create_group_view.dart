import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/funcs/loading_dialoag.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/groups/data/models/group_contact_model.dart';
import 'package:avora/features/groups/presentation/cubits/create_group/create_group_cubit.dart';
import 'package:avora/features/groups/presentation/cubits/create_group/create_group_state.dart';
import 'package:avora/features/groups/presentation/views/widgets/create_group/bottom_actions.dart';
import 'package:avora/features/groups/presentation/views/widgets/create_group/contacts_grid.dart';
import 'package:avora/features/groups/presentation/views/widgets/create_group/create_group_app_bar.dart';
import 'package:avora/features/groups/presentation/views/widgets/create_group/group_info_section.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  final _groupNameController = TextEditingController();

  final Set<String> _selectedContactIds = {};
  XFile? _groupImage;
  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  void _toggleContact(String contactId) {
    setState(() {
      if (_selectedContactIds.contains(contactId)) {
        _selectedContactIds.remove(contactId);
      } else {
        _selectedContactIds.add(contactId);
      }
    });
  }

  void _createGroup() {
    if (_groupNameController.text.trim().isEmpty) {
      return;
    }

    if (_selectedContactIds.isEmpty) {
      return;
    }

    context.read<CreateGroupCubit>().createGroup(
      name: _groupNameController.text,
      memberIds: _selectedContactIds.toList(),
      avatarFilePath: _groupImage?.path,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateGroupCubit, CreateGroupState>(
      listener: (context, state) {
        if (state is CreateGroupSuccess) {
          context.pop();
          ToastNoContext.showColoredToast(
            message: 'Group created successfully.',
          );
          context.pushReplacementNamed(
            AppRoutes.groupChatRoom,
            arguments: {'conversationId': state.conversationId},
          );
        }

        if (state is CreateGroupFailure) {
          ToastNoContext.showColoredToast(
            message: state.failure.message,
            color: AppColors.lightRed,
          );
          context.pop();
        }
        if (state is CreateGroupLoading) {
          loadingDialog(context);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: CreateGroupAppBar(),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.medium,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(AppSpacing.md),
                        GroupInformationSection(
                          controller: _groupNameController,
                          onImageSelected: (image) {
                            setState(() {
                              _groupImage = image;
                            });
                          },
                        ),
                        verticalSpace(AppSpacing.xl),
                        Text(
                          S.of(context).add_members,
                          style: TextStyles.bold19,
                        ),
                        verticalSpace(AppSpacing.xs),
                        Text(
                          S.of(context).choose_people_from,
                          style: TextStyles.regular13.copyWith(
                            color: AppColors.gray,
                          ),
                        ),
                        verticalSpace(AppSpacing.md),
                        ContactsGrid(
                          contacts: contacts,
                          selectedContactIds: _selectedContactIds,
                          onContactTap: _toggleContact,
                        ),
                        verticalSpace(AppSpacing.lg),
                      ],
                    ),
                  ),
                ),
                BottomActions(
                  onCancel: () => context.pop(),
                  onCreate: _createGroup,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
