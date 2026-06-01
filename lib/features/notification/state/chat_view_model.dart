import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/data/pagination/paged_list_state.dart';
import 'package:culcul/core/data/pagination/page_merge.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/data/notification_paging_constants.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_view_model.g.dart';

final class ChatState {
  ChatState({required this.paging, required Map<String, String> emojiMap})
    : emojiMap = Map<String, String>.unmodifiable(emojiMap);

  final PagedListState<PrivateMessage> paging;
  final Map<String, String> emojiMap;

  ChatState copyWith({
    PagedListState<PrivateMessage>? paging,
    Map<String, String>? emojiMap,
  }) {
    return ChatState(paging: paging ?? this.paging, emojiMap: emojiMap ?? this.emojiMap);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ChatState &&
            other.paging == paging &&
            mapEquals(other.emojiMap, emojiMap);
  }

  @override
  int get hashCode {
    return Object.hash(
      paging,
      Object.hashAllUnordered(
        emojiMap.entries.map((entry) => Object.hash(entry.key, entry.value)),
      ),
    );
  }

  @override
  String toString() {
    return 'ChatState(paging: $paging, emojiMap: $emojiMap)';
  }
}

@riverpod
class Chat extends _$Chat {
  int? _minSeqno;
  final NetworkConcurrencyExecutor _concurrencyExecutor =
      const NetworkConcurrencyExecutor();

  @override
  FutureOr<ChatState> build(int talkerId, PrivateSessionType sessionType) async {
    _minSeqno = null;

    final ownerUid = int.tryParse(ref.read(currentUserProvider)?.uid ?? '');
    if (ownerUid == null) {
      return ChatState(
        paging: const PagedListState(items: [], isInitialLoading: false),
        emojiMap: const {},
      );
    }

    final localSnapshot = await _loadLocalSnapshot(ownerUid: ownerUid);
    final localMessages = localSnapshot.messages;
    final emojiMap = localSnapshot.emojiMap;

    _updateMinSeq(localMessages);
    final initialMessages = _filterMessages(localMessages);

    unawaited(_syncHeadAndRefresh(ownerUid));

    return ChatState(
      paging: PagedListState(
        items: initialMessages,
        hasMore: _canLoadOlder(),
        isInitialLoading: false,
        nextPage: 2,
      ),
      emojiMap: emojiMap,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading) return;

    final ownerUid = int.tryParse(ref.read(currentUserProvider)?.uid ?? '');
    if (ownerUid == null) return;
    final current = state.value;
    if (current == null) return;
    if (!current.paging.hasMore || current.paging.isLoadingMore) return;

    if (_minSeqno == null || _minSeqno! <= 0) {
      state = AsyncData(
        current.copyWith(
          paging: current.paging.copyWith(hasMore: false, isLoadingMore: false),
        ),
      );
      return;
    }

    state = AsyncData(
      current.copyWith(paging: current.paging.copyWith(isLoadingMore: true, error: null)),
    );

    try {
      final repository = ref.read(notificationRepositoryProvider);
      await repository.syncMessagesOlder(
        ownerUid: ownerUid,
        talkerId: talkerId,
        sessionType: sessionType,
        endSeqno: _minSeqno!,
      );

      final localSnapshot = await _loadLocalSnapshot(
        ownerUid: ownerUid,
        endSeqno: _minSeqno,
      );
      final olderMessages = localSnapshot.messages;
      final emojiMap = localSnapshot.emojiMap;

      if (olderMessages.isEmpty) {
        final latest = state.value ?? current;
        state = AsyncData(
          latest.copyWith(
            paging: latest.paging.copyWith(isLoadingMore: false, hasMore: false),
            emojiMap: emojiMap,
          ),
        );
        return;
      }

      _updateMinSeq(olderMessages);
      final hasMoreAfterLoad =
          olderMessages.length >= notificationPrivateMessagePageSize && _canLoadOlder();

      final filteredOlder = _filterMessages(olderMessages);
      final latest = state.value ?? current;
      final merged = mergeUnique(
        latest.paging.items,
        filteredOlder,
        idGetter: (item) => item.msgSeqno,
      );
      state = AsyncData(
        latest.copyWith(
          paging: latest.paging.copyWith(
            items: merged,
            hasMore: hasMoreAfterLoad,
            isLoadingMore: false,
            error: null,
          ),
          emojiMap: emojiMap,
        ),
      );
    } catch (error) {
      final latest = state.value;
      if (latest != null) {
        state = AsyncData(
          latest.copyWith(
            paging: latest.paging.copyWith(isLoadingMore: false, error: error),
          ),
        );
      }
    }
  }

  Future<({Object? error, bool sent})> sendMessage(String content) async {
    if (content.trim().isEmpty) {
      return (sent: false, error: null);
    }
    return _send(
      messageType: PrivateMessageType.text,
      content: PrivateMessageContent.text(content),
    );
  }

  Future<({Object? error, bool sent})> sendImage(
    ({Uint8List bytes, String filename}) image,
  ) async {
    final uploadResult = await ref
        .read(notificationRepositoryProvider)
        .uploadImage(image.bytes, image.filename);
    final uploadRes = uploadResult.dataOrNull;
    if (uploadRes == null) {
      return _setPagingError(
        uploadResult.errorOrNull ?? const AppError.data('Failed to upload image'),
      );
    }

    final content = PrivateMessageContent.image(
      url: uploadRes.imageUrl,
      height: uploadRes.height,
      width: uploadRes.width,
      imageType: image.filename.split('.').last,
      size: image.bytes.length / 1024,
    );
    return _send(messageType: PrivateMessageType.image, content: content);
  }

  Future<({Object? error, bool sent})> _send({
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    final ownerUid = int.tryParse(ref.read(currentUserProvider)?.uid ?? '');
    if (ownerUid == null) {
      return _setPagingError(const AppError.auth('Not logged in'));
    }

    final repository = ref.read(notificationRepositoryProvider);
    final result = await repository.sendPrivateMessage(
      ownerUid: ownerUid,
      receiverId: talkerId,
      receiverType: sessionType.receiverType,
      messageType: messageType,
      content: content,
    );

    if (result.isFailure) {
      final error = result.errorOrNull ?? const AppError.data('Failed to send message');
      await _refreshHeadFromLocal(ownerUid);
      return _setPagingError(error);
    }

    await _refreshHeadFromLocal(ownerUid);
    return (sent: true, error: null);
  }

  ({Object? error, bool sent}) _setPagingError(AppError error) {
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(paging: current.paging.copyWith(error: error)));
    }
    return (sent: false, error: error);
  }

  Future<void> _syncHeadAndRefresh(int ownerUid) async {
    try {
      await ref
          .read(notificationRepositoryProvider)
          .syncMessagesHead(
            ownerUid: ownerUid,
            talkerId: talkerId,
            sessionType: sessionType,
          );
      await _refreshHeadFromLocal(ownerUid);
    } catch (_) {}
  }

  Future<void> _refreshHeadFromLocal(int ownerUid) async {
    final localSnapshot = await _loadLocalSnapshot(ownerUid: ownerUid);
    final head = localSnapshot.messages;
    final emojiMap = localSnapshot.emojiMap;
    final filtered = _filterMessages(head);
    _updateMinSeq(filtered);
    final current = state.value;
    if (current == null) return;

    final merged = mergeUnique(
      filtered,
      current.paging.items,
      idGetter: (item) => item.msgSeqno,
    );
    state = AsyncData(
      current.copyWith(
        paging: current.paging.copyWith(
          items: merged,
          hasMore: current.paging.hasMore && _canLoadOlder(),
          isInitialLoading: false,
          isLoadingMore: false,
          error: null,
        ),
        emojiMap: emojiMap,
      ),
    );
  }

  Future<({List<PrivateMessage> messages, Map<String, String> emojiMap})>
  _loadLocalSnapshot({required int ownerUid, int? endSeqno}) async {
    final repository = ref.read(notificationRepositoryProvider);
    final results = await _concurrencyExecutor.runConcurrent(
      tasks: <ConcurrentTask<dynamic>>[
        ConcurrentTask<List<PrivateMessage>>(
          label: 'messages',
          task: () => repository.pageMessagesFromLocal(
            ownerUid: ownerUid,
            talkerId: talkerId,
            sessionType: sessionType,
            endSeqno: endSeqno,
          ),
        ),
        ConcurrentTask<Map<String, String>>(
          label: 'emoji_map',
          critical: false,
          fallback: (_) => const <String, String>{},
          task: () => repository.getMessageEmojiMapFromLocal(
            ownerUid: ownerUid,
            talkerId: talkerId,
            sessionType: sessionType,
          ),
        ),
      ],
      profile: NetworkConcurrencyProfile.backgroundSync,
      scope: 'notification_chat_local_snapshot',
    );

    final messages =
        (results['messages'] as List<PrivateMessage>?) ?? const <PrivateMessage>[];
    final emojiMap =
        (results['emoji_map'] as Map<String, String>?) ?? const <String, String>{};
    return (messages: messages, emojiMap: emojiMap);
  }

  bool _canLoadOlder() {
    return _minSeqno != null && _minSeqno! > 0;
  }

  List<PrivateMessage> _filterMessages(List<PrivateMessage> source) {
    return source
        .where((message) => message.type != PrivateMessageType.withdrawn)
        .toList();
  }

  void _updateMinSeq(List<PrivateMessage> messages) {
    final positiveSeqs = messages
        .map((m) => m.msgSeqno)
        .where((seq) => seq > 0)
        .toList(growable: false);
    if (positiveSeqs.isEmpty) {
      _minSeqno = null;
      return;
    }
    _minSeqno = positiveSeqs.reduce(
      (value, element) => value < element ? value : element,
    );
  }
}
