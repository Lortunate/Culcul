part of 'chat_view_model.dart';

mixin _ChatHelpersMixin on _$Chat {
  NetworkConcurrencyExecutor get _concurrencyExecutor;
  int? get _minSeqno;
  set _minSeqno(int? value);

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
