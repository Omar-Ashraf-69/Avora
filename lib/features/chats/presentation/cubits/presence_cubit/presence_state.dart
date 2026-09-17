class PresenceState {
  const PresenceState({
    this.onlineUserIds = const {},
    this.lastSeenAtByUserId = const {},
  });

  final Set<String> onlineUserIds;
  final Map<String, DateTime?> lastSeenAtByUserId;

  bool isOnline(String userId) {
    return onlineUserIds.contains(userId);
  }

  DateTime? getLastSeen(String userId) {
    return lastSeenAtByUserId[userId];
  }
}