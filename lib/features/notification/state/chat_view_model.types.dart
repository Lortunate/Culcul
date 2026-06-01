part of 'chat_view_model.dart';

@freezed
sealed class ChatState with _$ChatState {
  const factory ChatState({
    required PagedListState<PrivateMessage> paging,
    required Map<String, String> emojiMap,
  }) = _ChatState;
}
