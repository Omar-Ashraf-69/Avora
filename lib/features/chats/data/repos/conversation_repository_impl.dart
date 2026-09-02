import 'dart:developer';

import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/data/data_source/conversation_remote_data_source.dart';
import 'package:avora/features/chats/domain/repos/conversation_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../generated/l10n.dart';
import '../../domain/entities/conversation_entity.dart';

class ConversationRepositoryImpl
    implements ConversationRepository {
  ConversationRepositoryImpl(this._remoteDataSource);

  final ConversationRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, String>> createDirectConversation({
    required String otherUserId,
  }) async {
    try {
      final conversationId =
          await _remoteDataSource.createDirectConversation(
        otherUserId: otherUserId,
      );

      return Right(conversationId);
    } on CustomException catch (e) {
      log(
        'ConversationRepositoryImpl.createDirectConversation',
        error: e,
      );

      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      log(
        'ConversationRepositoryImpl.createDirectConversation',
        error: e,
        stackTrace: stackTrace,
      );

      return Left(
        ServerFailure(
          S.current.unexpected_error,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>>
      getUserConversations() async {
    try {
      final models =
          await _remoteDataSource.getUserConversations();

      return Right(
        models.map((model) => model.toEntity()).toList(),
      );
    } on CustomException catch (e) {
      log(
        'ConversationRepositoryImpl.getUserConversations',
        error: e,
      );

      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      log(
        'ConversationRepositoryImpl.getUserConversations',
        error: e,
        stackTrace: stackTrace,
      );

      return Left(
        ServerFailure(
          S.current.unexpected_error,
        ),
      );
    }
  }
}