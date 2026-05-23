import 'dart:typed_data';

import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/application/chat_page_commands.dart';
import 'package:culcul/features/notification/application/notification_chat_application_providers.dart';
import 'package:culcul/features/notification/application/notification_chat_port.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/presentation/view_models/chat_view_model.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('chat list reads and paginates through the application chat provider', () async {
    final firstPage = _messages(20, startSeqno: 100);
    final olderPage = _messages(20, startSeqno: 80);
    final port = _FakeNotificationChatPort(
      firstPage: firstPage,
      olderPage: olderPage,
      emojiMap: const {'[smile]': 'https://example.test/smile.png'},
    );
    final container = _containerWith(port);
    addTearDown(container.dispose);

    final provider = chatProvider(7, PrivateSessionType.user);
    final state = await container.read(provider.future);
    await _waitForHeadSync(port);

    await container.read(provider.notifier).loadMore();

    expect(state.paging.items, firstPage);
    expect(state.emojiMap, port.emojiMap);
    expect(port.syncHeadCalls, [(ownerUid: 42, talkerId: 7)]);
    expect(port.syncOlderEndSeqnos, [81]);
    expect(port.pageEndSeqnos.any((endSeqno) => endSeqno == null), isTrue);
    expect(port.pageEndSeqnos.any((endSeqno) => endSeqno == 81), isTrue);
  });

  test('chat send commands use the application chat provider', () async {
    final port = _FakeNotificationChatPort(
      firstPage: _messages(20, startSeqno: 100),
      olderPage: const [],
      emojiMap: const {},
    );
    final container = _containerWith(port);
    addTearDown(container.dispose);

    final provider = chatProvider(7, PrivateSessionType.user);
    await container.read(provider.future);

    final textResult = await container.read(provider.notifier).sendMessage('hello');
    final imageResult = await container
        .read(provider.notifier)
        .sendImage(
          ChatImageAttachment(
            bytes: Uint8List.fromList(const [1, 2, 3]),
            filename: 'sample.png',
          ),
        );

    expect(textResult.isSuccess, isTrue);
    expect(imageResult.isSuccess, isTrue);
    expect(port.sentMessageTypes, [PrivateMessageType.text, PrivateMessageType.image]);
    expect(port.uploads, [('sample.png', 3)]);
  });
}

ProviderContainer _containerWith(_FakeNotificationChatPort port) {
  return ProviderContainer(
    retry: (_, _) => null,
    overrides: [
      notificationOwnerUidProvider.overrideWith((ref) => 42),
      notificationChatPortProvider.overrideWithValue(port),
      dioClientProvider.overrideWith(
        (ref) => throw StateError(
          'notificationRepositoryProvider dependencies should not be read by chat UI state',
        ),
      ),
      notificationLocalDatabaseProvider.overrideWith(
        (ref) => throw StateError(
          'notificationRepositoryProvider dependencies should not be read by chat UI state',
        ),
      ),
    ],
  );
}

Future<void> _waitForHeadSync(_FakeNotificationChatPort port) async {
  for (var attempt = 0; attempt < 20; attempt += 1) {
    if (port.syncHeadCalls.isNotEmpty) return;
    await Future<void>.delayed(Duration.zero);
  }
  fail('Expected initial chat load to trigger a background head sync.');
}

final class _FakeNotificationChatPort implements NotificationChatPort {
  _FakeNotificationChatPort({
    required this.firstPage,
    required this.olderPage,
    required this.emojiMap,
  });

  final List<PrivateMessage> firstPage;
  final List<PrivateMessage> olderPage;
  final Map<String, String> emojiMap;

  final pageEndSeqnos = <int?>[];
  final syncHeadCalls = <({int ownerUid, int talkerId})>[];
  final syncOlderEndSeqnos = <int>[];
  final sentMessageTypes = <PrivateMessageType>[];
  final uploads = <(String filename, int byteLength)>[];

  @override
  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) async {
    pageEndSeqnos.add(endSeqno);
    return endSeqno == null ? firstPage : olderPage;
  }

  @override
  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    return emojiMap;
  }

  @override
  Future<Result<void, AppError>> syncMessagesHead({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    syncHeadCalls.add((ownerUid: ownerUid, talkerId: talkerId));
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> syncMessagesOlder({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required int endSeqno,
  }) async {
    syncOlderEndSeqnos.add(endSeqno);
    return const Success(null);
  }

  @override
  Future<Result<ImageUploadResult, AppError>> uploadImage(
    Uint8List bytes,
    String filename,
  ) async {
    uploads.add((filename, bytes.length));
    return const Success(
      ImageUploadResult(
        imageUrl: 'https://example.test/image.png',
        imageWidth: 320,
        imageHeight: 180,
      ),
    );
  }

  @override
  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    sentMessageTypes.add(messageType);
    return const Success(SendMessageResult(msgKey: 1));
  }
}

List<PrivateMessage> _messages(int count, {required int startSeqno}) {
  return List.generate(
    count,
    (index) => PrivateMessage(
      senderUid: index.isEven ? 42 : 7,
      receiverType: PrivateMessageReceiverType.user,
      receiverId: 7,
      type: PrivateMessageType.text,
      content: PrivateMessageContent.text('message $index'),
      msgSeqno: startSeqno - index,
      timestamp: 1000 + index,
    ),
  );
}
