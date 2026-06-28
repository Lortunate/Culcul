import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_local_database.g.dart';

class NotificationMessages extends Table {
  IntColumn get ownerUid => integer()();
  IntColumn get sessionType => integer()();
  IntColumn get talkerId => integer()();
  IntColumn get msgSeqno => integer()();

  IntColumn get senderUid => integer()();
  IntColumn get receiverType => integer()();
  IntColumn get receiverId => integer()();
  IntColumn get msgType => integer()();
  TextColumn get contentJson => text()();

  IntColumn get timestamp => integer()();
  TextColumn get atUidsJson => text().nullable()();
  IntColumn get msgKey => integer().nullable()();
  IntColumn get msgStatus => integer().nullable()();
  TextColumn get notifyCode => text().nullable()();
  IntColumn get newFaceVersion => integer().nullable()();
  IntColumn get msgSource => integer().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {ownerUid, sessionType, talkerId, msgSeqno};
}

class NotificationMessageEmojis extends Table {
  IntColumn get ownerUid => integer()();
  IntColumn get sessionType => integer()();
  IntColumn get talkerId => integer()();
  TextColumn get emojiText => text()();
  TextColumn get emojiUrl => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {ownerUid, sessionType, talkerId, emojiText};
}

class NotificationSessions extends Table {
  IntColumn get ownerUid => integer()();
  IntColumn get sessionType => integer()();
  IntColumn get talkerId => integer()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  IntColumn get sessionTs => integer()();
  TextColumn get sessionJson => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {ownerUid, sessionType, talkerId};
}

class NotificationFeedItems extends Table {
  IntColumn get ownerUid => integer()();
  TextColumn get feedType => text()();
  IntColumn get eventId => integer()();
  IntColumn get eventTime => integer()();
  TextColumn get itemJson => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {ownerUid, feedType, eventId};
}

class NotificationUnreadSummaries extends Table {
  IntColumn get ownerUid => integer()();
  TextColumn get summaryJson => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {ownerUid};
}

class NotificationSyncCursors extends Table {
  IntColumn get ownerUid => integer()();
  TextColumn get scope => text()();
  TextColumn get cursorJson => text().nullable()();
  BoolColumn get hasMore => boolean().withDefault(const Constant(true))();
  IntColumn get lastSyncedAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {ownerUid, scope};
}

class NotificationOutbox extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ownerUid => integer()();
  IntColumn get sessionType => integer()();
  IntColumn get talkerId => integer()();
  IntColumn get localMsgSeqno => integer()();
  IntColumn get senderUid => integer()();
  IntColumn get receiverType => integer()();
  IntColumn get receiverId => integer()();
  IntColumn get msgType => integer()();
  TextColumn get contentJson => text()();
  IntColumn get timestamp => integer()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get error => text().nullable()();
  IntColumn get msgKey => integer().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

@DriftDatabase(
  tables: [
    NotificationMessages,
    NotificationMessageEmojis,
    NotificationSessions,
    NotificationFeedItems,
    NotificationUnreadSummaries,
    NotificationSyncCursors,
    NotificationOutbox,
  ],
)
class NotificationLocalDatabase extends _$NotificationLocalDatabase {
  NotificationLocalDatabase({QueryExecutor? executor})
    : super(
        executor ??
            driftDatabase(
              name: 'notification.sqlite',
              native: const DriftNativeOptions(),
            ),
      );

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notification_message_emojis_lookup '
        'ON notification_message_emojis(owner_uid, session_type, talker_id)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notification_message_emojis_updated_at '
        'ON notification_message_emojis(owner_uid, updated_at)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notification_messages_time '
        'ON notification_messages(owner_uid, session_type, talker_id, timestamp DESC, msg_seqno DESC)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notification_sessions_ts '
        'ON notification_sessions(owner_uid, session_type, session_ts DESC)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notification_feed_time '
        'ON notification_feed_items(owner_uid, feed_type, event_time DESC, event_id DESC)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notification_outbox_lookup '
        'ON notification_outbox(owner_uid, session_type, talker_id, status, created_at ASC)',
      );
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(notificationMessageEmojis);
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_notification_message_emojis_lookup '
          'ON notification_message_emojis(owner_uid, session_type, talker_id)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_notification_message_emojis_updated_at '
          'ON notification_message_emojis(owner_uid, updated_at)',
        );
      }
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notification_messages_time '
        'ON notification_messages(owner_uid, session_type, talker_id, timestamp DESC, msg_seqno DESC)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notification_sessions_ts '
        'ON notification_sessions(owner_uid, session_type, session_ts DESC)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notification_feed_time '
        'ON notification_feed_items(owner_uid, feed_type, event_time DESC, event_id DESC)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notification_outbox_lookup '
        'ON notification_outbox(owner_uid, session_type, talker_id, status, created_at ASC)',
      );
    },
  );
}

@Riverpod(keepAlive: true)
NotificationLocalDatabase notificationLocalDatabase(Ref ref) {
  final db = NotificationLocalDatabase();
  ref.onDispose(db.close);
  return db;
}
