
import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/data/data_source/image_storage_data_source.dart';
import 'package:avora/features/chats/data/data_source/message_remote_data_source.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/domain/repos/message_repository.dart';
import 'package:avora/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class MessageRepositoryImpl implements MessageRepository {
  const MessageRepositoryImpl(
    this.remoteDataSource, {required this.imageStorageDataSource}
  );

  final MessageRemoteDataSource remoteDataSource;
  final ImageStorageDataSource imageStorageDataSource;

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
 @override
  Future<Either<Failure, MessageEntity>> sendImageMessage({
    required String conversationId,
    required String filePath,
  }) async {
    String? uploadedImagePath;

    try {
      // 1. Generate the message ID first.
      final messageId = const Uuid().v4();

      // 2. Upload the image to Supabase Storage.
      uploadedImagePath = await imageStorageDataSource.uploadChatImage(
        conversationId: conversationId,
        messageId: messageId,
        filePath: filePath,
      );

      // 3. Create the message in the database.
      final model = await remoteDataSource.sendImageMessage(
        conversationId: conversationId,
        messageId: messageId,
        imagePath: uploadedImagePath,
      );

      // 4. Convert the model to a domain entity.
      return Right(model.toEntity());
    } on CustomException catch (e) {
      await _deleteUploadedImage(uploadedImagePath);

      return Left(
        ServerFailure(e.message),
      );
    } catch (_) {
      await _deleteUploadedImage(uploadedImagePath);

      return Left(
        ServerFailure(
          S.current.unexpected_error,
        ),
      );
    }
  }

  Future<void> _deleteUploadedImage(String? path) async {
    if (path == null) {
      return;
    }

    try {
      await imageStorageDataSource.deleteChatImage(
        path: path,
      );
    } catch (_) {
      // Ignore cleanup errors.
      // The original error is more important.
    }
  }

  @override
Future<Either<Failure, void>> markConversationAsRead({
  required String conversationId,
}) async {
  try {
    await remoteDataSource.markConversationAsRead(
      conversationId: conversationId,
    );

    return const Right(null);
  } on CustomException catch (e) {
    return Left(
      ServerFailure(
         e.message,
      ),
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