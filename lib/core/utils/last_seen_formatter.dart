class LastSeenFormatter {
  static String format(DateTime? lastSeenAt) {
    if (lastSeenAt == null) {
      return 'Last seen recently';
    }

    final localTime = lastSeenAt.toLocal();

    final hour = localTime.hour % 12 == 0
        ? 12
        : localTime.hour % 12;

    final minute = localTime.minute.toString().padLeft(2, '0');

    final period = localTime.hour >= 12 ? 'PM' : 'AM';

    return 'Last seen $hour:$minute $period';
  }
}