part of 'chat_view_model.dart';

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
