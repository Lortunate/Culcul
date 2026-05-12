import 'dart:async';

import 'package:culcul/features/notification/application/chat_page_commands.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/data/pagination/paged_list_state.dart';
import 'package:culcul/core/utils/list_utils.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/feature_scope.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_view_model.freezed.dart';
part 'chat_view_model.g.dart';
part 'chat_view_model.helpers.dart';
part 'chat_view_model.send.dart';
part 'chat_view_model.types.dart';

@riverpod
class Chat extends _$Chat with _ChatHelpersMixin, _ChatSendMixin {
  @override
  int? _minSeqno;
  @override
  final NetworkConcurrencyExecutor _concurrencyExecutor =
      const NetworkConcurrencyExecutor();

  @override
  FutureOr<ChatState> build(int talkerId, PrivateSessionType sessionType) async {
    _minSeqno = null;

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
        isLoadingMore: false,
        nextPage: 2,
      ),
      emojiMap: emojiMap,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading) return;

    final ownerUid = ref.read(notificationOwnerUidProvider);
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
      final hasMoreAfterLoad = olderMessages.length >= 20 && _canLoadOlder();

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
}
