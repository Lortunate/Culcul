import 'package:culcul/core/session/user_providers.dart';
import 'package:culcul/features/notification/application/chat_page_commands.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/presentation/view_models/chat_view_model.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/features/notification/presentation/widgets/chat_input.dart';
import 'package:culcul/features/notification/presentation/widgets/chat_message_list.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_skeletons.dart';
import 'package:culcul/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatPage extends HookConsumerWidget {
  final int talkerId;
  final String? name;
  final PrivateSessionType sessionType;
  final String? avatarUrl;

  const ChatPage({
    super.key,
    required this.talkerId,
    this.name,
    this.sessionType = PrivateSessionType.user,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = chatProvider(talkerId, sessionType);
    final chatState = ref.watch(provider);
    final session = ref.watch(currentUserProvider);
    final notifier = ref.read(provider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    final displayInfo = _resolveDisplayInfo(ref);
    final displayAvatarUrl = displayInfo.avatarUrl;
    final displayName = displayInfo.name;

    final workflow = ref.read(chatPageCommandWorkflowProvider);
    final textController = useTextEditingController();
    final scrollController = useScrollController();

    // Current user ID (int)
    final currentUserId = useMemoized(() {
      return int.tryParse(session?.uid ?? '0') ?? 0;
    }, [session?.uid]);

    Future<void> scrollToBottom() async {
      if (!scrollController.hasClients) {
        return;
      }
      await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    void showSendError(Object error) {
      if (!context.mounted) {
        return;
      }
      final t = i18n(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.notification.chat.send_failed(error: error.toString()))),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: Text(displayName), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: chatState.when(
              data: (state) => ChatMessageList(
                paging: state.paging,
                emojiMap: state.emojiMap,
                currentUserId: currentUserId,
                selfAvatarUrl: session?.avatarUrl ?? '',
                otherAvatarUrl: displayAvatarUrl,
                scrollController: scrollController,
                onLoadMore: notifier.loadMore,
              ),
              error: (err, stack) => AppErrorWidget(
                error: err,
                stackTrace: stack,
                onRetry: () => ref.refresh(provider),
              ),
              loading: () => const ChatMessageSkeletonList(),
            ),
          ),
          ChatInput(
            controller: textController,
            onSendImage: (image) async {
              final result = await workflow.sendImage(
                image: image,
                send: notifier.sendImage,
                afterSuccess: scrollToBottom,
              );
              if (result.isFailure) {
                showSendError(result.error ?? StateError('Unknown send failure'));
              }
            },
            onSend: () async {
              final result = await workflow.sendText(
                text: textController.text,
                send: notifier.sendMessage,
                clearInput: textController.clear,
                afterSuccess: scrollToBottom,
              );
              if (result.isFailure) {
                showSendError(result.error ?? StateError('Unknown send failure'));
              }
            },
          ),
        ],
      ),
    );
  }

  ({String avatarUrl, String name}) _resolveDisplayInfo(WidgetRef ref) {
    var displayAvatarUrl = avatarUrl ?? '';
    var displayName = name ?? 'Chat';

    if (sessionType != PrivateSessionType.user) {
      return (avatarUrl: displayAvatarUrl, name: displayName);
    }

    final profileAsync = ref.watch(userProfileInfoProvider(talkerId.toString()));
    if (!profileAsync.hasValue) return (avatarUrl: displayAvatarUrl, name: displayName);

    final profile = profileAsync.value;
    if (profile == null) return (avatarUrl: displayAvatarUrl, name: displayName);
    if (displayAvatarUrl.isEmpty) {
      displayAvatarUrl = profile.avatarUrl;
    }
    displayName = profile.name;
    return (avatarUrl: displayAvatarUrl, name: displayName);
  }
}
