import 'dart:developer';

import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/services/database/data_base_service.dart';
import 'package:avora/features/groups/data/data_sources/group_remote_data_source.dart';
import 'package:avora/features/groups/data/models/create_group_model.dart';
import 'package:avora/features/groups/data/models/group_details_model.dart';
import 'package:avora/features/groups/data/models/group_list_model.dart';
import 'package:avora/generated/l10n.dart';

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  const GroupRemoteDataSourceImpl({required this.databaseService});

  final DatabaseService databaseService;

  @override
  Future<String> createGroup({required CreateGroupModel group}) async {
    try {
      final response = await databaseService.rpc(
        functionName: 'create_group',
        params: group.toRpcParams(),
      );

      if (response == null) {
        throw CustomException(message: S.current.failed_to_create_group);
      }

      return response as String;
    } catch (e) {
      if (e is CustomException) {
        rethrow;
      }

      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<GroupDetailsModel> getGroupDetails({
    required String conversationId,
  }) async {
    try {
      final response = await databaseService.rpc(
        functionName: 'get_group_details',
        params: {'p_conversation_id': conversationId},
      );

      return GroupDetailsModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> updateGroupAvatar({
    required String conversationId,
    required String avatarUrl,
  }) async {
    await databaseService.rpc(
      functionName: 'update_group_avatar',
      params: {'p_conversation_id': conversationId, 'p_avatar_url': avatarUrl},
    );
  }

  @override
  Future<List<GroupListItemModel>> getGroups() async {
    try {
      final result = await databaseService.rpc(functionName: 'get_groups');

      return List<Map<String, dynamic>>.from(
        result,
      ).map((json) => GroupListItemModel.fromJson(json)).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<void> finalizeGroupCreation({
    required String conversationId,
    required List<String> memberIds,
  }) async {
    try {
      await databaseService.rpc(
        functionName: 'finalize_group_creation',
        params: {
          'p_conversation_id': conversationId,
          'p_member_ids': memberIds,
        },
      );
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
