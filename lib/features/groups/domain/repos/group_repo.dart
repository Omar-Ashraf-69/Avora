import 'package:avora/core/error/failures.dart';
import 'package:avora/features/groups/data/params/create_group_params.dart';
import 'package:avora/features/groups/domain/entities/group_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GroupRepository {
  Future<Either<Failure, String>> createGroup({
    required CreateGroupParams params,
  });
    Future<Either<Failure, GroupDetailsEntity>> getGroupDetails({
    required String conversationId,
  });
}