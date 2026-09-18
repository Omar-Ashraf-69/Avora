import 'package:avora/features/groups/domain/entities/group_member_entity.dart';

class GroupDetailsEntity {
  const GroupDetailsEntity({
    required this.id,
    required this.conversationId,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
    this.description,
    this.avatarUrl,
  });

  final String id;
  final String conversationId;
  final String name;
  final String? description;
  final String? avatarUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<GroupMemberEntity> members;
}