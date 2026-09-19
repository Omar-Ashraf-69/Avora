import 'dart:developer';

import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/failures.dart';
import 'package:avora/features/groups/data/params/create_group_params.dart';
import 'package:avora/features/groups/domain/entities/group_details_entity.dart';
import 'package:avora/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:avora/features/groups/data/data_sources/group_remote_data_source.dart';
import 'package:avora/features/groups/data/models/create_group_model.dart';
import 'package:avora/features/groups/domain/repos/group_repo.dart';

class GroupRepositoryImpl implements GroupRepository {
  const GroupRepositoryImpl({required this._remoteDataSource});

  final GroupRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, String>> createGroup({
    required CreateGroupParams params,
  }) async {
    try {
      final groupModel = CreateGroupModel.fromEntity(params);

      final conversationId = await _remoteDataSource.createGroup(
        group: groupModel,
      );

      return Right(conversationId);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroupDetailsEntity>> getGroupDetails({
    required String conversationId,
  }) async {
    try {
      final model = await _remoteDataSource.getGroupDetails(
        conversationId: conversationId,
      );

      return Right(model.toEntity());
    } on CustomException catch (e) {
      log('GroupRepositoryImpl.getGroupDetails', error: e);

      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      log(
        'GroupRepositoryImpl.getGroupDetails',
        error: e,
        stackTrace: stackTrace,
      );

      return Left(ServerFailure(S.current.unexpected_error));
    }
  }

  @override
  Future<Either<Failure, void>> updateGroupAvatar({
    required String conversationId,
    required String avatarUrl,
  }) async {
    try {
      await _remoteDataSource.updateGroupAvatar(
        conversationId: conversationId,
        avatarUrl: avatarUrl,
      );

      return const Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Failed to update group image.'));
    }
  }
}
