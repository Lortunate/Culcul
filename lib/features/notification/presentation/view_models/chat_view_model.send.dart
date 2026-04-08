part of 'chat_view_model.dart';

mixin _ChatSendMixin on _$Chat, _ChatHelpersMixin {
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
}
