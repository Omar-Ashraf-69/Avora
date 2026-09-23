import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:flutter/material.dart';

import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/groups/domain/entities/group_member_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SystemMessageBubble extends StatelessWidget {
  const SystemMessageBubble({
    super.key,
    required this.message,
    required this.currentUserId,
    required this.members,
  });

  final MessageEntity message;
  final String currentUserId;
  final List<GroupMemberEntity> members;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppPadding.medium.w,
          vertical: 2.h,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.lighterGray,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          _buildMessage(),
          textAlign: TextAlign.center,
          style: TextStyles.regular13.copyWith(color: AppColors.gray),
        ),
      ),
    );
  }

  String _buildMessage() {
    switch (message.systemEvent) {
      case SystemMessageType.membersAdded:
        return _buildMembersAddedMessage();

      case null:
        return '';
    }
  }

  String _buildMembersAddedMessage() {
    final userIds = message.metadata?['user_ids'];

    if (userIds is! List) {
      return 'New members were added to the group';
    }

    final addedUserIds = userIds.whereType<String>().toList();

    if (addedUserIds.isEmpty) {
      return 'New members were added to the group';
    }

    final actor = _findMember(message.senderId);

    final actorName = actor?.name ?? 'Someone';

    final addedMembers = members
        .where((member) => addedUserIds.contains(member.userId))
        .toList();

    /*
     * The current user is one of the added members.
     */
    final currentUserWasAdded = addedUserIds.contains(currentUserId);

    /*
     * Remove the current user from the list because
     * we want to say "you" instead of their name.
     */
    final otherMembers = addedMembers
        .where((member) => member.userId != currentUserId)
        .toList();

    /*
     * Only the current user was added.
     *
     * Omar added you to the group
     */
    if (currentUserWasAdded && otherMembers.isEmpty) {
      return '$actorName added you to the group';
    }

    /*
     * Current user + other members.
     *
     * Omar added Ahmed, Sara and you to the group
     */
    if (currentUserWasAdded) {
      final names = otherMembers.map((member) => member.name).toList();

      return '$actorName added '
          '${_formatNames(names)} '
          'and you to the group';
    }

    /*
     * Current user was not added.
     *
     * Omar added Ahmed and Sara to the group
     */
    if (addedMembers.isNotEmpty) {
      final names = addedMembers.map((member) => member.name).toList();

      return '$actorName added '
          '${_formatNames(names)} '
          'to the group';
    }

    /*
     * Fallback in case the members aren't available yet.
     */
    return '$actorName added new members to the group';
  }

  GroupMemberEntity? _findMember(String userId) {
    for (final member in members) {
      if (member.userId == userId) {
        return member;
      }
    }

    return null;
  }

  String _formatNames(List<String> names) {
    if (names.isEmpty) {
      return 'new members';
    }

    if (names.length == 1) {
      return names.first;
    }

    if (names.length == 2) {
      return '${names[0]} and ${names[1]}';
    }

    return '${names.sublist(0, names.length - 1).join(', ')} '
        'and ${names.last}';
  }
}
