import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/profile/application/profile_session_providers.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/state/chat_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/presentation/widgets/chat_input.dart';
import 'package:culcul/features/notification/presentation/widgets/chat_message_list.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
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
      final t = context.t;
      context.showAppFeedback(
        t.notification.chat.send_failed(error: error.toString()),
        level: AppFeedbackLevel.error,
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
              loading: () => ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: CulculSpacing.sm,
                  vertical: CulculSpacing.md,
                ),
                itemCount: 10,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: CulculSpacing.lg),
                itemBuilder: (context, index) {
                  final isSelf = index.isEven;
                  return AppShimmer(
                    child: Row(
                      mainAxisAlignment: isSelf
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isSelf) ...[
                          const AppShimmerBox(width: 40, height: 40, borderRadius: 20),
                          const SizedBox(width: CulculSpacing.xs),
                        ],
                        Container(
                          width: 150 + (isSelf ? 30.0 : 0.0),
                          height: 40,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.only(
                              topLeft: CulculRadius.radiusMd,
                              topRight: CulculRadius.radiusMd,
                              bottomLeft: isSelf
                                  ? CulculRadius.radiusMd
                                  : CulculRadius.radiusXs,
                              bottomRight: isSelf
                                  ? CulculRadius.radiusXs
                                  : CulculRadius.radiusMd,
                            ),
                          ),
                        ),
                        if (isSelf) ...[
                          const SizedBox(width: CulculSpacing.xs),
                          const AppShimmerBox(width: 40, height: 40, borderRadius: 20),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          ChatInput(
            controller: textController,
            onSendImage: (image) async {
              final result = await notifier.sendImage(image);
              if (result.sent) {
                await scrollToBottom();
                return;
              }
              final error = result.error;
              if (error != null) {
                showSendError(error);
              }
            },
            onSend: () async {
              final result = await notifier.sendMessage(textController.text);
              if (result.sent) {
                textController.clear();
                await scrollToBottom();
                return;
              }
              final error = result.error;
              if (error != null) {
                showSendError(error);
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

    final profileAsync = ref.watch(userProfileCardProvider(talkerId.toString()));
    if (!profileAsync.hasValue) return (avatarUrl: displayAvatarUrl, name: displayName);

    final profile = profileAsync.value?.dataOrNull;
    if (profile == null) return (avatarUrl: displayAvatarUrl, name: displayName);
    if (displayAvatarUrl.isEmpty) {
      displayAvatarUrl = profile.face;
    }
    displayName = profile.name;
    return (avatarUrl: displayAvatarUrl, name: displayName);
  }
}
