enum NotificationFeedType {
  reply('reply'),
  at('at'),
  like('like'),
  system('system');

  const NotificationFeedType(this.value);

  final String value;
}
