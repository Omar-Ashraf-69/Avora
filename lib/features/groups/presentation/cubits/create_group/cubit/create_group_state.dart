import 'package:avora/core/error/failures.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class CreateGroupState {
  const CreateGroupState();
}

final class CreateGroupInitial extends CreateGroupState {
  const CreateGroupInitial();
}

final class CreateGroupLoading extends CreateGroupState {
  const CreateGroupLoading();
}

final class CreateGroupSuccess extends CreateGroupState {
  const CreateGroupSuccess({
    required this.conversationId,
  });

  final String conversationId;
}

final class CreateGroupFailure extends CreateGroupState {
  const CreateGroupFailure({
    required this.failure,
  });

  final Failure failure;
}