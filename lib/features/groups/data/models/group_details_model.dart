import '../../domain/entities/group_details_entity.dart';
import '../../domain/entities/group_member_entity.dart';

class GroupMemberModel {
  const GroupMemberModel({
    required this.userId,
    required this.name,
    this.avatarUrl,
  });

  final String userId;
  final String name;
  final String? avatarUrl;

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) {
    return GroupMemberModel(
      userId: json['user_id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  GroupMemberEntity toEntity() {
    return GroupMemberEntity(
      userId: userId,
      name: name,
      avatarUrl: avatarUrl,
    );
  }
}

class GroupDetailsModel {
  const GroupDetailsModel({
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
  final List<GroupMemberModel> members;

  factory GroupDetailsModel.fromJson(Map<String, dynamic> json) {
    return GroupDetailsModel(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      members: (json['members'] as List<dynamic>)
          .map(
            (member) => GroupMemberModel.fromJson(
              member as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  GroupDetailsEntity toEntity() {
    return GroupDetailsEntity(
      id: id,
      conversationId: conversationId,
      name: name,
      description: description,
      avatarUrl: avatarUrl,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      members: members.map((member) => member.toEntity()).toList(),
    );
  }
}