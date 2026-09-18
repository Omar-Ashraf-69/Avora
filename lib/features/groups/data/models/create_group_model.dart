
import 'package:avora/features/groups/data/params/create_group_params.dart';

class CreateGroupModel {
  const CreateGroupModel({
    required this.name,
    required this.memberIds,
    this.description,
    this.avatarUrl,
  });

  final String name;
  final String? description;
  final String? avatarUrl;
  final List<String> memberIds;

  factory CreateGroupModel.fromEntity(CreateGroupParams params) {
    return CreateGroupModel(
      name: params.name,
      description: params.description,
      avatarUrl: params.avatarUrl,
      memberIds: params.memberIds,
    );
  }

  Map<String, dynamic> toRpcParams() {
    return {
      'p_name': name,
      'p_description': description,
      'p_avatar_url': avatarUrl,
      'p_member_ids': memberIds,
    };
  }
}