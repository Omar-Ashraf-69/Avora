

import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/features/groups/data/models/group_contact_model.dart';
import 'package:avora/features/groups/presentation/views/widgets/create_group/contacts_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsGrid extends StatelessWidget {
  const ContactsGrid({super.key, 
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

        return ContactGridItem(
          contact: contact,
          isSelected: isSelected,
          onTap: () => onContactTap(contact.id),
        );
      },
    );
  }
}
