
import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/data/data_source/message_remote_data_source.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/domain/repos/message_repository.dart';
import 'package:avora/generated/l10n.dart';
import 'package:dartz/dartz.dart';

class MessageRepositoryImpl implements MessageRepository {
  const MessageRepositoryImpl(
    this.remoteDataSource,
  );

  final MessageRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required String conversationId,
  }) async {
    try {
      final models = await remoteDataSource.getMessages(
        conversationId: conversationId,
      );

      return Right(
        models.map((model) => model.toEntity()).toList(),
      );
    } on CustomException catch (e) {
      return Left(
        ServerFailure( e.message),
      );
    } catch (_) {
      return Left(
        ServerFailure(
           S.current.unexpected_error,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendTextMessage({
    required String conversationId,
    required String content,
  }) async {
    try {
      final model = await remoteDataSource.sendTextMessage(
        conversationId: conversationId,
        content: content,
      );

      return Right(model.toEntity());
    } on CustomException catch (e) {
      return Left(
        ServerFailure( e.message),
      );
    } catch (_) {
      return Left(
        ServerFailure(
           S.current.unexpected_error,
        ),
      );
    }
  }
}