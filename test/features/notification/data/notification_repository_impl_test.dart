import 'dart:io';

import 'package:culcul/core/network/models/api_response.dart';
import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeNotificationApi implements NotificationApi {
  _FakeNotificationApi({
    required this.unreadCount,
    required this.replyResponse,
    required this.systemSessionResponse,
    required this.systemMessageResponse,
  });

  final UnreadCountModel unreadCount;
  final ReplyResponse replyResponse;
  final PrivateMessageSessionResponse systemSessionResponse;
  final PrivateMessageListResponse systemMessageResponse;
  int? lastSessionType;
  int? lastMessageTalkerId;
  int? lastMessageSessionType;

  @override
  Future<ApiResponse<UnreadCountModel>> getUnreadCount() async {
    return ApiResponse(code: 0, message: 'ok', data: unreadCount);
  }

  @override
  Future<ApiResponse<ReplyResponse>> getReplyList({int? id, int? replyTime}) async {
    return ApiResponse(code: 0, message: 'ok', data: replyResponse);
  }

  @override
  Future<ApiResponse<ReplyResponse>> getAtList({int? id, int? atTime}) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<LikeResponse>> getLikeList({int? id, int? likeTime}) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<PrivateMessageSessionResponse>> getPrivateSessions({
    int sessionType = 1,
    int size = 20,
    int? endTs,
  }) async {
    lastSessionType = sessionType;
    return ApiResponse(code: 0, message: 'ok', data: systemSessionResponse);
  }

  @override
  Future<ApiResponse<PrivateMessageListResponse>> getPrivateMessages({
    required int talkerId,
    int sessionType = 1,
    int size = 20,
    int? beginSeqno,
    int? endSeqno,
    int senderDeviceId = 1,
    int build = 0,
    String mobiApp = 'web',
  }) async {
    lastMessageTalkerId = talkerId;
    lastMessageSessionType = sessionType;
    return ApiResponse(code: 0, message: 'ok', data: systemMessageResponse);
  }

  @override
  Future<ApiResponse<ImageUploadResponse>> uploadImage({
    required File file,
    String biz = 'draw',
    String category = 'daily',
    int build = 0,
    String mobiApp = 'web',
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<SendMessageResponse>> sendPrivateMessage({
    required int wSenderUid,
    required int wReceiverId,
    required String wDevId,
    required int senderUid,
    required int receiverId,
    required int receiverType,
    required int msgType,
    required String devId,
    required int timestamp,
    required String content,
  }) async {
    throw UnimplementedError();
  }
}

void main() {
  late NotificationLocalDatabase db;
  late NotificationRepositoryImpl repository;
  late _FakeNotificationApi fakeApi;

  setUp(() {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final replyResponse = ReplyResponse(
      cursor: const ReplyCursor(isEnd: false, id: 10, time: 1700000000),
      items: const [
        ReplyItem(
          id: 10,
          users: null,
          user: ReplyUser(
            mid: 1,
            fans: 0,
            nickname: 'alice',
            avatar: 'https://example.com/avatar.png',
            midLink: '',
            follow: false,
          ),
          item: ReplyItemDetail(
            subjectId: 100,
            rootId: 10,
            sourceId: 0,
            targetId: 0,
            type: 'reply',
            businessId: 1,
            business: 'archive',
            title: 'title',
            desc: 'desc',
            image: '',
            uri: '',
            nativeUri: '',
            rootReplyContent: '',
            sourceContent: 'source',
            targetReplyContent: '',
            atDetails: [],
            hideReplyButton: false,
            hideLikeButton: false,
            likeState: 0,
            message: 'hello',
          ),
          counts: 1,
          isMulti: 0,
          replyTime: 1700000000,
          likeTime: null,
        ),
      ],
      lastViewAt: 0,
    );

    fakeApi = _FakeNotificationApi(
      unreadCount: const UnreadCountModel(at: 1, chat: 2, like: 3, reply: 4, system: 5),
      replyResponse: replyResponse,
      systemSessionResponse: const PrivateMessageSessionResponse(
        sessionList: [],
        hasMore: 0,
        systemMsg: {'7': 10086},
      ),
      systemMessageResponse: PrivateMessageListResponse(
        messages: [
          PrivateMessageDetail(
            senderUid: 10086,
            receiverType: 1,
            receiverId: 1001,
            msgType: 10,
            content: {
              'title': 'old',
              'text': 'old text',
              'jump_uri': 'https://old.example.com',
              'jump_text': 'view',
            },
            msgSeqno: 1,
            timestamp: now - 1,
          ),
          PrivateMessageDetail(
            senderUid: 10086,
            receiverType: 1,
            receiverId: 1001,
            msgType: 10,
            content: {
              'title': 'new',
              'content': '{"text":"new content","url":"https://new.example.com"}',
              'jump_text': 'open',
            },
            msgSeqno: 2,
            timestamp: now,
          ),
        ],
        emojiInfos: const [
          PrivateMessageEmojiInfo(text: 'doge', url: 'https://example.com/doge.png'),
        ],
      ),
    );

    db = NotificationLocalDatabase(executor: NativeDatabase.memory());
    repository = NotificationRepositoryImpl(fakeApi, db);
  });

  tearDown(() async {
    await db.close();
  });

  test('watchUnreadCount fallback and sync update', () async {
    final initial = await repository.watchUnreadCount(ownerUid: 1001).first;
    expect(initial.at, 0);
    expect(initial.system, 0);

    await repository.syncUnreadCount(ownerUid: 1001, force: true);
    final summary = await repository.watchUnreadCount(ownerUid: 1001).first;

    expect(summary.at, 1);
    expect(summary.chat, 2);
    expect(summary.like, 3);
    expect(summary.reply, 4);
    expect(summary.system, 5);
  });

  test('syncFeedHead is idempotent by business key', () async {
    await repository.syncFeedHead(ownerUid: 1001, type: NotificationFeedType.reply);
    await repository.syncFeedHead(ownerUid: 1001, type: NotificationFeedType.reply);

    final items = await repository.pageFeedFromLocal(
      ownerUid: 1001,
      type: NotificationFeedType.reply,
    );
    expect(items.length, 1);
    expect(items.first.id, 10);
  });

  test('watchSystemNotices emits items sorted by event time desc', () async {
    await repository.syncFeedHead(ownerUid: 1001, type: NotificationFeedType.system);

    final notices = await repository
        .watchSystemNotices(ownerUid: 1001)
        .firstWhere((items) => items.isNotEmpty);

    expect(notices.length, 2);
    expect(notices.first.id, 2);
    expect(notices.first.title, 'new');
    expect(notices.first.text, 'new content');
    expect(notices.first.uri, 'https://new.example.com');
    expect(notices.first.jumpText, 'open');
    expect(notices.last.text, 'old text');
    expect(notices.last.uri, 'https://old.example.com');
    expect(fakeApi.lastSessionType, 7);
    expect(fakeApi.lastMessageSessionType, 1);
    expect(fakeApi.lastMessageTalkerId, 10086);
  });

  test('syncMessagesHead stores emoji map and supports bracket/plain keys', () async {
    await repository.syncMessagesHead(
      ownerUid: 1001,
      talkerId: 2002,
      sessionType: PrivateSessionType.user,
    );

    final emojiMap = await repository.getMessageEmojiMapFromLocal(
      ownerUid: 1001,
      talkerId: 2002,
      sessionType: PrivateSessionType.user,
    );

    expect(emojiMap['[doge]'], 'https://example.com/doge.png');
    expect(emojiMap['doge'], 'https://example.com/doge.png');
  });
}
