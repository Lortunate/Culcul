final class NotificationFeedCursor {
  const NotificationFeedCursor({required this.id, required this.time});

  final int id;
  final int time;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NotificationFeedCursor && other.id == id && other.time == time;
  }

  @override
  int get hashCode => Object.hash(id, time);

  @override
  String toString() => 'NotificationFeedCursor(id: $id, time: $time)';
}
