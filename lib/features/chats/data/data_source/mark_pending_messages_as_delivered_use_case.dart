import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/repos/message_repository.dart';
import 'package:dartz/dartz.dart';

class MarkPendingMessagesAsDeliveredUseCase {
  const MarkPendingMessagesAsDeliveredUseCase(this._repository);

  final MessageRepository _repository;

  Future<Either<Failure, void>> call() {
    return _repository.markPendingMessagesAsDelivered();
  }
}