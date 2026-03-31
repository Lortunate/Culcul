import 'package:culcul/core/errors/app_error.dart';
import 'dart:io';

import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/notification/application/notification_workflows.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_view_model.g.dart';

class ChatState {
  final List<PrivateMessage> messages;
  final Map<String, String> emojiMap;

  const ChatState({required this.messages, required this.emojiMap});

  ChatState copyWith({List<PrivateMessage>? messages, Map<String, String>? emojiMap}) {
    return ChatState(
      messages: messages ?? this.messages,
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

    final result = await ref
        .read(notificationWorkflowsProvider)
        .getPrivateMessages(talkerId: talkerId, sessionType: sessionType);
    final response = result.when(
      success: (value) => value,
      failure: (error) => throw error,
    );
    if (response.messages.isNotEmpty) {
      _minSeqno = response.messages.last.msgSeqno;
    }
    _hasMore = response.hasMore;

    final emojiMap = <String, String>{};
    for (final emoji in response.emojiInfos) {
      emojiMap[emoji.text] = emoji.url;
    }

    // Filter out withdrawn notification messages (msg_type: 5)
    final messages = response.messages.where((message) => message.msgType != 5).toList();
    return ChatState(messages: messages, emojiMap: emojiMap);
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    try {
      final result = await ref
          .read(notificationWorkflowsProvider)
          .getPrivateMessages(
            talkerId: talkerId,
            sessionType: sessionType,
            endSeqno: _minSeqno,
          );
      if (result.isFailure) {
        return;
      }
      final response = result.dataOrNull!;
      final newMessages = response.messages;
      if (newMessages.isNotEmpty) {
        _minSeqno = newMessages.last.msgSeqno;
        final filteredNew = newMessages.where((m) => m.msgType != 5).toList();

        final currentState = state.value;
        if (currentState != null) {
          final currentList = currentState.messages;
          final currentMap = Map<String, String>.from(currentState.emojiMap);

          for (final emoji in response.emojiInfos) {
            currentMap[emoji.text] = emoji.url;
          }

          state = AsyncData(
            currentState.copyWith(
              messages: [...currentList, ...filteredNew],
              emojiMap: currentMap,
            ),
          );
        }
      }
      _hasMore = response.hasMore;
    } catch (e) {
      // Keep current list on pagination failure; UI should remain usable.
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    await _send(msgType: 1, content: PrivateMessageContent.text(content));
  }

  Future<void> sendImage(File imageFile) async {
    // Upload first
    final uploadResult = await ref
        .read(notificationWorkflowsProvider)
        .uploadImage(imageFile);
    if (uploadResult.isFailure) {
      throw uploadResult.errorOrNull!;
    }
    final uploadRes = uploadResult.dataOrNull!;
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

    // 1. Optimistic Update
    final tempMessage = PrivateMessage(
      msgSeqno: 0, // Temporary ID
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
        currentState.copyWith(messages: [tempMessage, ...currentState.messages]),
      );
    }

    try {
      final result = await ref
          .read(notificationWorkflowsProvider)
          .sendPrivateMessage(
            senderUid: senderUid,
            receiverId: talkerId,
            receiverType: sessionType,
            msgType: msgType,
            content: content,
          );
      if (result.isFailure) {
        throw result.errorOrNull!;
      }
    } catch (e) {
      // Failure: Revert state
      state = previousState;
      rethrow;
    }
  }
}
