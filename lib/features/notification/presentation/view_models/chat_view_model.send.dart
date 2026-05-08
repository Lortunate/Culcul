part of 'chat_view_model.dart';

mixin _ChatSendMixin on _$Chat, _ChatHelpersMixin {
  Future<ChatPageCommandResult> sendMessage(String content) async {
    if (content.trim().isEmpty) {
      return const ChatPageCommandResult.skipped();
    }
    return _send(
      messageType: PrivateMessageType.text,
      content: PrivateMessageContent.text(content),
    );
  }

  Future<ChatPageCommandResult> sendImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final filename = imageFile.path.split('/').last.split('\\').last;
    final uploadResult = await ref
        .read(notificationRepositoryProvider)
        .uploadImage(bytes, filename);
    final uploadRes = uploadResult.dataOrNull;
    if (uploadRes == null) {
      return _setPagingError(
        uploadResult.errorOrNull ?? AppError.data('Failed to upload image'),
      );
    }

    final content = PrivateMessageContent.image(
      url: uploadRes.imageUrl,
      height: uploadRes.imageHeight,
      width: uploadRes.imageWidth,
      imageType: filename.split('.').last,
      size: bytes.length / 1024,
    );
    return _send(messageType: PrivateMessageType.image, content: content);
  }

  Future<ChatPageCommandResult> _send({
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null) {
      return _setPagingError(AppError.auth('Not logged in'));
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
      final error = result.errorOrNull ?? AppError.data('Failed to send message');
      await _refreshHeadFromLocal(ownerUid);
      return _setPagingError(error);
    }

    await _refreshHeadFromLocal(ownerUid);
    return const ChatPageCommandResult.success();
  }

  ChatPageCommandResult _setPagingError(AppError error) {
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(paging: current.paging.copyWith(error: error)));
    }
    return ChatPageCommandResult.failure(error);
  }
}
