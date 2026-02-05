import 'dart:io';
import 'package:culcul/ui/pages/notification/providers/chat_provider.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/providers/profile/profile_provider.dart';
import 'package:culcul/ui/pages/notification/widgets/chat_input.dart';
import 'package:culcul/ui/pages/notification/widgets/chat_message_list.dart';
import 'package:culcul/ui/pages/notification/widgets/notification_skeletons.dart';
import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatPage extends HookConsumerWidget {
  final int talkerId;
  final String? name;
  final int sessionType;
  final String? avatarUrl;

  const ChatPage({
    super.key,
    required this.talkerId,
    this.name,
    this.sessionType = 1,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider(talkerId, sessionType));
    final currentUser = ref.watch(authProvider).user;

    // 获取对方信息
    String displayAvatarUrl = avatarUrl ?? '';
    String displayName = name ?? 'Chat';

    if (sessionType == 1) {
      final profileAsync = ref.watch(userProfileProvider(talkerId.toString()));
      if (profileAsync.hasValue) {
        final profile = profileAsync.value!;
        if (displayAvatarUrl.isEmpty) {
          displayAvatarUrl = profile.avatarUrl ?? '';
        }
        displayName = profile.username;
      }
    }

    final textController = useTextEditingController();
    final scrollController = useScrollController();

    // 当前用户 ID (Int)
    final currentUserId = useMemoized(() {
      return int.tryParse(currentUser?.id ?? '0') ?? 0;
    }, [currentUser?.id]);

    return Scaffold(
      appBar: AppBar(title: Text(displayName), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: chatState.when(
              data: (state) => ChatMessageList(
                messages: state.messages,
                emojiMap: state.emojiMap,
                currentUserId: currentUserId,
                selfAvatarUrl: currentUser?.avatarUrl ?? '',
                otherAvatarUrl: displayAvatarUrl,
                scrollController: scrollController,
                onLoadMore: () async {
                  final notifier = ref.read(
                    chatProvider(talkerId, sessionType).notifier,
                  );
                  await notifier.loadMore();
                },
              ),
              error: (err, stack) => Center(child: Text('Error: $err')),
              loading: () => const ChatMessageSkeletonList(),
            ),
          ),
          ChatInput(
            controller: textController,
            onSendImage: (File image) async {
              try {
                await ref
                    .read(chatProvider(talkerId, sessionType).notifier)
                    .sendImage(image);
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('发送图片失败: $e')));
                }
              }
            },
            onSend: () async {
              if (textController.text.isNotEmpty) {
                try {
                  await ref
                      .read(chatProvider(talkerId, sessionType).notifier)
                      .sendMessage(textController.text);
                  textController.clear();
                  // Scroll to bottom (which is 0 in reverse list)
                  if (scrollController.hasClients) {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('发送失败: $e')));
                  }
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
