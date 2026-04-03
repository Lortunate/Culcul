import 'dart:async';
import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/pagination/paged_list_state.dart';
import 'package:culcul/core/utils/list_utils.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/notification.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_view_model.g.dart';

class ChatState {
  const ChatState({required this.paging, required this.emojiMap});

  final PagedListState<PrivateMessage> paging;
  final Map<String, String> emojiMap;

  ChatState copyWith({
    PagedListState<PrivateMessage>? paging,
    Map<String, String>? emojiMap,
  }) {
    return ChatState(paging: paging ?? this.paging, emojiMap: emojiMap ?? this.emojiMap);
  }
}

@riverpod
class Chat extends _$Chat {
  int? _minSeqno;
  bool _hasMore = true;

  @override
  FutureOr<ChatState> build(int talkerId, PrivateSessionType sessionType) async {
    _minSeqno = null;
    _hasMore = true;

    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null) {
      return const ChatState(
        paging: PagedListState(
          items: [],
          hasMore: false,
          isInitialLoading: false,
          isLoadingMore: false,
        ),
        emojiMap: {},
      );
    }

    final repository = ref.read(notificationRepositoryProvider);
    final localMessages = await repository.pageMessagesFromLocal(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
    );

    _updateMinSeq(localMessages);
    final initialMessages = _filterMessages(localMessages);

    unawaited(_syncHeadAndRefresh(ownerUid));

    return ChatState(
      paging: PagedListState(
        items: initialMessages,
        hasMore: _hasMore,
        isInitialLoading: false,
        isLoadingMore: false,
        nextPage: 2,
      ),
      emojiMap: const <String, String>{},
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null) return;
    final current = state.value;
    if (current == null) return;

    if (_minSeqno == null || _minSeqno! <= 0) {
      _hasMore = false;
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

      final olderMessages = await repository.pageMessagesFromLocal(
        ownerUid: ownerUid,
        talkerId: talkerId,
        sessionType: sessionType,
        endSeqno: _minSeqno,
      );

      if (olderMessages.isEmpty) {
        _hasMore = false;
        final latest = state.value ?? current;
        state = AsyncData(
          latest.copyWith(
            paging: latest.paging.copyWith(isLoadingMore: false, hasMore: false),
          ),
        );
        return;
      }

      _updateMinSeq(olderMessages);
      if (olderMessages.length < 20) {
        _hasMore = false;
      }

      final filteredOlder = _filterMessages(olderMessages);
      final latest = state.value ?? current;
      final merged = ListUtils.mergeUnique(
        latest.paging.items,
        filteredOlder,
        idGetter: (item) => item.msgSeqno,
      );
      state = AsyncData(
        latest.copyWith(
          paging: latest.paging.copyWith(
            items: merged,
            hasMore: _hasMore,
            isLoadingMore: false,
            error: null,
          ),
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

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    await _send(
      messageType: PrivateMessageType.text,
      content: PrivateMessageContent.text(content),
    );
  }

  Future<void> sendImage(File imageFile) async {
    final uploadResult = await ref
        .read(notificationRepositoryProvider)
        .uploadImage(imageFile);
    final uploadRes = uploadResult.dataOrNull;
    if (uploadRes == null) {
      final current = state.value;
      if (current != null) {
        state = AsyncData(
          current.copyWith(
            paging: current.paging.copyWith(error: uploadResult.errorOrNull),
          ),
        );
      }
      return;
    }

    final content = PrivateMessageContent.image(
      url: uploadRes.imageUrl,
      height: uploadRes.imageHeight,
      width: uploadRes.imageWidth,
      imageType: imageFile.path.split('.').last,
      size: await imageFile.length() / 1024,
    );
    await _send(messageType: PrivateMessageType.image, content: content);
  }

  Future<void> _send({
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null) {
      final message = AppError.auth('Not logged in');
      final current = state.value;
      if (current != null) {
        state = AsyncData(
          current.copyWith(paging: current.paging.copyWith(error: message)),
        );
      }
      return;
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
      final current = state.value;
      if (current != null) {
        state = AsyncData(
          current.copyWith(paging: current.paging.copyWith(error: result.errorOrNull)),
        );
      }
    }

    await _refreshHeadFromLocal(ownerUid);
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
    final repository = ref.read(notificationRepositoryProvider);
    final head = await repository.pageMessagesFromLocal(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
    );
    final filtered = _filterMessages(head);
    _updateMinSeq(filtered);
    final current = state.value;
    if (current == null) return;

    final merged = ListUtils.mergeUnique(
      filtered,
      current.paging.items,
      idGetter: (item) => item.msgSeqno,
    );
    state = AsyncData(
      current.copyWith(
        paging: current.paging.copyWith(
          items: merged,
          hasMore: _hasMore,
          isInitialLoading: false,
          isLoadingMore: false,
          error: null,
        ),
      ),
    );
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
