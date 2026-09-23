import 'package:avora/features/groups/data/models/create_group_model.dart';
import 'package:avora/features/groups/data/models/group_details_model.dart';
import 'package:avora/features/groups/data/models/group_list_model.dart';

abstract class GroupRemoteDataSource {
  Future<String> createGroup({required CreateGroupModel group});
  Future<GroupDetailsModel> getGroupDetails({required String conversationId});
  Future<void> finalizeGroupCreation({
    required String conversationId,
    required List<String> memberIds,
  });
  Future<void> updateGroupAvatar({
    required String conversationId,
    required String avatarUrl,
  });

  Future<List<GroupListItemModel>> getGroups();
}
