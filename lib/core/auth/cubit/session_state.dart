sealed class SessionState {
  const SessionState();
}

final class SessionInitial extends SessionState {
  const SessionInitial();
}

final class SessionLoading extends SessionState {
  const SessionLoading();
}

final class SessionAuthenticated extends SessionState {
  const SessionAuthenticated();
}

final class SessionUnauthenticated extends SessionState {
  const SessionUnauthenticated();
}