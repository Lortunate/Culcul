import 'dart:convert';
import 'dart:io';

import 'package:culcul/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:culcul/features/notification/application/use_case/notification_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_view_model.g.dart';

class ChatState {
  final List<PrivateMessageDetail> messages;
  final Map<String, String> emojiMap;

  const ChatState({required this.messages, required this.emojiMap});

  ChatState copyWith({
    List<PrivateMessageDetail>? messages,
    Map<String, String>? emojiMap,
  }) {
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
        .read(notificationUseCasesProvider)
        .getPrivateMessages(talkerId: talkerId, sessionType: sessionType);
    final response = result.when(
      success: (value) => value,
      failure: (error) => throw Exception(error.message),
    );
    if (response.messages != null && response.messages!.isNotEmpty) {
      _minSeqno = response.messages!.last.msgSeqno;
    }
    _hasMore = response.hasMore == 1;

    final emojiMap = <String, String>{};
    if (response.emojiInfos != null) {
      for (final e in response.emojiInfos!) {
        emojiMap[e.text] = e.url;
      }
    }

    // Filter out withdrawn notification messages (msg_type: 5)
    final messages = (response.messages ?? []).where((m) => m.msgType != 5).toList();
    return ChatState(messages: messages, emojiMap: emojiMap);
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    try {
      final result = await ref
          .read(notificationUseCasesProvider)
          .getPrivateMessages(
            talkerId: talkerId,
            sessionType: sessionType,
            endSeqno: _minSeqno,
          );
      if (result.isFailure) {
        return;
      }
      final response = result.dataOrNull!;
      final newMessages = response.messages ?? [];
      if (newMessages.isNotEmpty) {
        _minSeqno = newMessages.last.msgSeqno;
        final filteredNew = newMessages.where((m) => m.msgType != 5).toList();

        final currentState = state.value;
        if (currentState != null) {
          final currentList = currentState.messages;
          final currentMap = Map<String, String>.from(currentState.emojiMap);

          if (response.emojiInfos != null) {
            for (final e in response.emojiInfos!) {
              currentMap[e.text] = e.url;
            }
          }

          state = AsyncData(
            currentState.copyWith(
              messages: [...currentList, ...filteredNew],
              emojiMap: currentMap,
            ),
          );
        }
      }
      _hasMore = response.hasMore == 1;
    } catch (e) {
      // Keep current list on pagination failure; UI should remain usable.
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    await _send(msgType: 1, contentMap: {'content': content});
  }

  Future<void> sendImage(File imageFile) async {
    // Upload first
    final uploadResult = await ref
        .read(notificationUseCasesProvider)
        .uploadImage(imageFile);
    if (uploadResult.isFailure) {
      throw Exception(uploadResult.errorOrNull!.message);
    }
    final uploadRes = uploadResult.dataOrNull!;
    final contentMap = {
      'url': uploadRes.imageUrl,
      'height': uploadRes.imageHeight,
      'width': uploadRes.imageWidth,
      'imageType': imageFile.path.split('.').last,
      'original': 1,
      'size': await imageFile.length() / 1024, // KB
    };
    await _send(msgType: 2, contentMap: contentMap);
  }

  Future<void> _send({
    required int msgType,
    required Map<String, dynamic> contentMap,
  }) async {
    final currentUser = ref.read(authProvider).user;

    if (currentUser == null) {
      throw StateError('Not logged in');
    }

    final senderUid = int.parse(currentUser.id);
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // 1. Optimistic Update
    final tempMessage = PrivateMessageDetail(
      msgSeqno: 0, // Temporary ID
      senderUid: senderUid,
      receiverId: talkerId,
      receiverType: sessionType,
      msgType: msgType,
      msgStatus: 0,
      timestamp: timestamp,
      content: contentMap,
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
          .read(notificationUseCasesProvider)
          .sendPrivateMessage(
            senderUid: senderUid,
            receiverId: talkerId,
            receiverType: sessionType,
            msgType: msgType,
            content: jsonEncode(contentMap),
          );
      if (result.isFailure) {
        throw Exception(result.errorOrNull!.message);
      }
    } catch (e) {
      // Failure: Revert state
      state = previousState;
      rethrow;
    }
  }
}
