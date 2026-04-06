import 'package:culcul/i18n/i18n.dart';
import 'dart:io';
import 'package:culcul/features/notification/presentation/view_models/chat_view_model.dart';
import 'package:culcul/features/auth/presentation.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/profile/presentation.dart';
import 'package:culcul/features/notification/presentation/widgets/chat_input.dart';
import 'package:culcul/features/notification/presentation/widgets/chat_message_list.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_skeletons.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
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
    final currentUser = ref.watch(authProvider).user;
    final notifier = ref.read(provider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    final displayInfo = _resolveDisplayInfo(ref);
    final displayAvatarUrl = displayInfo.avatarUrl;
    final displayName = displayInfo.name;

    final textController = useTextEditingController();
    final scrollController = useScrollController();

    // Current user ID (int)
    final currentUserId = useMemoized(() {
      return int.tryParse(currentUser?.id ?? '0') ?? 0;
    }, [currentUser?.id]);

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
                selfAvatarUrl: currentUser?.avatarUrl ?? '',
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
            onSendImage: (File image) => _sendImage(
              context: context,
              notifier: notifier,
              scrollController: scrollController,
              image: image,
            ),
            onSend: () async {
              final text = textController.text;
              if (text.isEmpty) return;
              await _sendText(
                context: context,
                notifier: notifier,
                scrollController: scrollController,
                textController: textController,
                text: text,
              );
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

    final profileAsync = ref.watch(userProfileProvider(talkerId.toString()));
    if (!profileAsync.hasValue) return (avatarUrl: displayAvatarUrl, name: displayName);

    final profile = profileAsync.value!;
    if (displayAvatarUrl.isEmpty) {
      displayAvatarUrl = profile.avatarUrl ?? '';
    }
    displayName = profile.username;
    return (avatarUrl: displayAvatarUrl, name: displayName);
  }

  Future<void> _sendImage({
    required BuildContext context,
    required Chat notifier,
    required ScrollController scrollController,
    required File image,
  }) async {
    try {
      await notifier.sendImage(image);
      await _scrollToBottom(scrollController);
    } catch (e) {
      if (!context.mounted) return;
      final t = i18n(context);
      _showSendError(context, t.notification.chat.send_failed(error: e.toString()));
    }
  }

  Future<void> _sendText({
    required BuildContext context,
    required Chat notifier,
    required ScrollController scrollController,
    required TextEditingController textController,
    required String text,
  }) async {
    try {
      await notifier.sendMessage(text);
      textController.clear();
      await _scrollToBottom(scrollController);
    } catch (e) {
      if (!context.mounted) return;
      final t = i18n(context);
      _showSendError(context, t.notification.chat.send_failed(error: e.toString()));
    }
  }

  Future<void> _scrollToBottom(ScrollController controller) async {
    if (!controller.hasClients) return;
    await controller.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _showSendError(BuildContext context, String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
