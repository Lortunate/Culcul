import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/pagination/paged_list_state.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_view_model.g.dart';

class ChatState {
  final PagedListState<PrivateMessage> paging;
  final Map<String, String> emojiMap;

  const ChatState({required this.paging, required this.emojiMap});

  ChatState copyWith({
    PagedListState<PrivateMessage>? paging,
    Map<String, String>? emojiMap,
  }) {
    return ChatState(
      paging: paging ?? this.paging,
      emojiMap: emojiMap ?? this.emojiMap,
    );
  }
}

@riverpod
class Chat extends _$Chat {
  int? _minSeqno;
  bool _hasMore = true;

  @override
  FutureOr<ChatState> build(int talkerId, int sessionType) async {
    _minSeqno = null;
    _hasMore = true;

    final response = await ref
        .read(notificationRepositoryProvider)
        .getPrivateMessages(talkerId: talkerId, sessionType: sessionType);
    if (response.messages.isNotEmpty) {
      _minSeqno = response.messages.last.msgSeqno;
    }
    _hasMore = response.hasMore;

    final emojiMap = <String, String>{};
    for (final emoji in response.emojiInfos) {
      emojiMap[emoji.text] = emoji.url;
    }

    final messages = response.messages.where((message) => message.msgType != 5).toList();
    return ChatState(
      paging: PagedListState(
        items: messages,
        hasMore: response.hasMore,
        isInitialLoading: false,
        isLoadingMore: false,
        nextPage: 2,
      ),
      emojiMap: emojiMap,
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final currentState = state.value;
    if (currentState != null) {
      state = AsyncData(
        currentState.copyWith(
          paging: currentState.paging.copyWith(isLoadingMore: true, error: null),
        ),
      );
    }

    try {
      final response = await ref
          .read(notificationRepositoryProvider)
          .getPrivateMessages(
            talkerId: talkerId,
            sessionType: sessionType,
            endSeqno: _minSeqno,
          );
      final newMessages = response.messages;
      if (newMessages.isNotEmpty) {
        _minSeqno = newMessages.last.msgSeqno;
        final filteredNew = newMessages.where((m) => m.msgType != 5).toList();

        final latestState = state.value;
        if (latestState != null) {
          final currentList = latestState.paging.items;
          final currentMap = Map<String, String>.from(latestState.emojiMap);

          for (final emoji in response.emojiInfos) {
            currentMap[emoji.text] = emoji.url;
          }

          state = AsyncData(
            latestState.copyWith(
              paging: latestState.paging.copyWith(
                items: [...currentList, ...filteredNew],
                hasMore: response.hasMore,
                isLoadingMore: false,
                error: null,
              ),
              emojiMap: currentMap,
            ),
          );
        }
      } else if (currentState != null) {
        state = AsyncData(
          currentState.copyWith(
            paging: currentState.paging.copyWith(
              hasMore: response.hasMore,
              isLoadingMore: false,
              error: null,
            ),
          ),
        );
      }
      _hasMore = response.hasMore;
    } catch (error) {
      final latestState = state.value;
      if (latestState != null) {
        state = AsyncData(
          latestState.copyWith(
            paging: latestState.paging.copyWith(isLoadingMore: false, error: error),
          ),
        );
      }
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    await _send(msgType: 1, content: PrivateMessageContent.text(content));
  }

  Future<void> sendImage(File imageFile) async {
    final uploadRes = await ref
        .read(notificationRepositoryProvider)
        .uploadImage(imageFile);
    final content = PrivateMessageContent.image(
      url: uploadRes.imageUrl,
      height: uploadRes.imageHeight,
      width: uploadRes.imageWidth,
      imageType: imageFile.path.split('.').last,
      size: await imageFile.length() / 1024,
    );
    await _send(msgType: 2, content: content);
  }

  Future<void> _send({
    required int msgType,
    required PrivateMessageContent content,
  }) async {
    final currentUser = ref.read(authProvider).user;

    if (currentUser == null) {
      throw AppError.auth('Not logged in');
    }

    final senderUid = int.parse(currentUser.id);
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final tempMessage = PrivateMessage(
      msgSeqno: 0,
      senderUid: senderUid,
      receiverId: talkerId,
      receiverType: sessionType,
      msgType: msgType,
      msgStatus: 0,
      timestamp: timestamp,
      content: content,
      atUids: null,
      msgKey: null,
      notifyCode: null,
      newFaceVersion: null,
      msgSource: null,
    );

    final previousState = state;
    final currentState = state.value;

    if (currentState != null) {
      state = AsyncData(
        currentState.copyWith(
          paging: currentState.paging.copyWith(
            items: [tempMessage, ...currentState.paging.items],
          ),
        ),
      );
    }

    try {
      await ref
          .read(notificationRepositoryProvider)
          .sendPrivateMessage(
            senderUid: senderUid,
            receiverId: talkerId,
            receiverType: sessionType,
            msgType: msgType,
            content: content,
          );
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}
