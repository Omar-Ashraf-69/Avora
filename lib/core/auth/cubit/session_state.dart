import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

class SessionInitial extends SessionState {
  const SessionInitial();
}

class SessionLoading extends SessionState {
  const SessionLoading();
}

class SessionUnauthenticated extends SessionState {
  const SessionUnauthenticated();
}

class SessionProfileIncomplete extends SessionState {
  const SessionProfileIncomplete();
}

class SessionAuthenticated extends SessionState {
  final ProfileEntity profile;

  const SessionAuthenticated({
    required this.profile,
  });

  @override
  List<Object?> get props => [profile];
}

class SessionFailure extends SessionState {
  final String message;

  const SessionFailure(this.message);

  @override
  List<Object?> get props => [message];
}

