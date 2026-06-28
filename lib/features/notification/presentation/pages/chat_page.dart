import 'dart:typed_data';

import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/profile/application/profile_session_providers.dart';
import 'package:culcul/features/notification/models/private_session.dart';
import 'package:culcul/features/notification/state/chat_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/presentation/widgets/chat_message_list.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

    var displayAvatarUrl = avatarUrl ?? '';
    var displayName = name ?? 'Chat';
    if (sessionType == PrivateSessionType.user) {
      final profileAsync = ref.watch(userProfileCardProvider(talkerId.toString()));
      if (profileAsync.hasValue) {
        final profile = profileAsync.value?.dataOrNull;
        if (profile != null) {
          if (displayAvatarUrl.isEmpty) {
            displayAvatarUrl = profile.face;
          }
          displayName = profile.name;
        }
      }
    }

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

    Future<void> sendPickedImage(({Uint8List bytes, String filename}) image) async {
      final result = await notifier.sendImage(image);
      if (result.sent) {
        await scrollToBottom();
        return;
      }
      final error = result.error;
      if (error != null) {
        showSendError(error);
      }
    }

    Future<void> sendText() async {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    child: IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: colorScheme.outline,
                        size: 28,
                      ),
                      onPressed: () async {
                        final picker = ImagePicker();
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile == null) {
                          return;
                        }
                        final bytes = await pickedFile.readAsBytes();
                        final filename = pickedFile.name.isNotEmpty
                            ? pickedFile.name
                            : pickedFile.path.split('/').last.split('\\').last;
                        await sendPickedImage((bytes: bytes, filename: filename));
                      },
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: textController,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: context.t.notification.chat.input_hint,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          isDense: true,
                        ),
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) async {
                          await sendText();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    child: IconButton.filled(
                      icon: const Icon(Icons.send_rounded, size: 20),
                      onPressed: () async {
                        await sendText();
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.all(10),
                        minimumSize: const Size(40, 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
