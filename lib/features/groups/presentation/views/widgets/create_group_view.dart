import 'dart:io';

import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/groups/data/models/group_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  final _groupNameController = TextEditingController();

  final List<GroupContact> _contacts = const [
    GroupContact(id: '1', name: 'Andrew', imageUrl: ''),
    GroupContact(id: '2', name: 'Sarah', imageUrl: ''),
    GroupContact(id: '3', name: 'John', imageUrl: ''),
    GroupContact(id: '4', name: 'Emma', imageUrl: ''),
    GroupContact(id: '5', name: 'Michael', imageUrl: ''),
    GroupContact(id: '6', name: 'Sophia', imageUrl: ''),
    GroupContact(id: '7', name: 'David', imageUrl: ''),
    GroupContact(id: '8', name: 'Olivia', imageUrl: ''),
  ];

  final Set<String> _selectedContactIds = {};

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

    // Create the group using the selected contacts.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Group', style: TextStyles.bold23),
        surfaceTintColor: Colors.transparent,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.medium,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(AppSpacing.md),

                    _GroupInformationSection(controller: _groupNameController),

                    verticalSpace(AppSpacing.xl),

                    Text('Add Members', style: TextStyles.bold19),

                    verticalSpace(AppSpacing.xs),

                    Text(
                      'Choose people from your chats to add to the group.',
                      style: TextStyles.regular13.copyWith(
                        color: AppColors.gray,
                      ),
                    ),

                    verticalSpace(AppSpacing.md),

                    _ContactsGrid(
                      contacts: _contacts,
                      selectedContactIds: _selectedContactIds,
                      onContactTap: _toggleContact,
                    ),

                    verticalSpace(AppSpacing.lg),
                  ],
                ),
              ),
            ),

            _BottomActions(
              onCancel: () => Navigator.pop(context),
              onCreate: _createGroup,
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupInformationSection extends StatelessWidget {
  const _GroupInformationSection({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _GroupAvatarPicker(),

        horizontalSpace(AppSpacing.md),

        Expanded(
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Group name',
              hintStyle: TextStyles.regular16.copyWith(
                color: AppColors.lightGray,
              ),
              filled: true,
              fillColor: AppColors.lightWhite,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.mainBlue,
                  width: .75,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GroupAvatarPicker extends StatefulWidget {
  const _GroupAvatarPicker();

  @override
  State<_GroupAvatarPicker> createState() => _GroupAvatarPickerState();
}

class _GroupAvatarPickerState extends State<_GroupAvatarPicker> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 70.sp,
          height: 70.sp,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lighterGray,
          ),
          child: image != null
              ? Image.file(File(image!.path), fit: BoxFit.cover)
              : HugeIcon(
                  icon: HugeIcons.strokeRoundedUserGroup,
                  size: 36.sp,
                  color: AppColors.gray,
                ),
        ),

        Positioned(
          right: -2.w,
          bottom: -2.h,
          child: Material(
            color: AppColors.mainBlue,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () async {
                final picker = ImagePicker();
                // Pick an image.
                image = await picker.pickImage(source: ImageSource.gallery);
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.all(7.r),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedCamera01,
                  size: 15.sp,
                  color: AppColors.lightWhite,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactsGrid extends StatelessWidget {
  const _ContactsGrid({
    required this.contacts,
    required this.selectedContactIds,
    required this.onContactTap,
  });

  final List<GroupContact> contacts;
  final Set<String> selectedContactIds;
  final ValueChanged<String> onContactTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: contacts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: 12.w,
        childAspectRatio: .78,
      ),
      itemBuilder: (context, index) {
        final contact = contacts[index];
        final isSelected = selectedContactIds.contains(contact.id);

        return _ContactGridItem(
          contact: contact,
          isSelected: isSelected,
          onTap: () => onContactTap(contact.id),
        );
      },
    );
  }
}

class _ContactGridItem extends StatelessWidget {
  const _ContactGridItem({
    required this.contact,
    required this.isSelected,
    required this.onTap,
  });

  final GroupContact contact;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(isSelected ? 3.r : 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: AppColors.mainBlue, width: 2)
                      : null,
                ),
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColors.lighterGray,
                  backgroundImage: contact.imageUrl.isNotEmpty
                      ? NetworkImage(contact.imageUrl)
                      : null,
                  child: contact.imageUrl.isEmpty
                      ? HugeIcon(
                          icon: HugeIcons.strokeRoundedUser,
                          size: 28.sp,
                          color: AppColors.gray,
                        )
                      : null,
                ),
              ),

              if (isSelected)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(3.r),
                    decoration: const BoxDecoration(
                      color: AppColors.mainBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 14.sp,
                      color: AppColors.lightWhite,
                    ),
                  ),
                ),
            ],
          ),

          verticalSpace(AppSpacing.xs),

          Text(
            contact.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.semiBold13,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.onCancel, required this.onCreate});

  final VoidCallback onCancel;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.medium,
        AppPadding.small,
        AppPadding.medium,
        AppPadding.medium,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: AppColors.lighterGray, width: .7),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              label: 'Cancel',
              onPressed: onCancel,
              color: AppColors.lightRed,
            ),
          ),
          horizontalSpace(AppSpacing.md),

          Expanded(
            child: CustomButton(label: 'Create', onPressed: onCreate),
          ),
        ],
      ),
    );
  }
}
