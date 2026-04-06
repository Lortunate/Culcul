import 'package:culcul/features/live/presentation/view_models/live_room_view_model.dart';
import 'package:culcul/features/live/presentation/view_models/live_danmaku_feed_view_model.dart';
import 'package:culcul/features/live/presentation/widgets/live_danmaku_view.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveRoomContent extends ConsumerWidget {
  final int roomId;

  const LiveRoomContent({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = liveRoomControllerProvider(roomId);
    final isLoading = ref.watch(provider.select((value) => value.isLoading));
    final error = ref.watch(provider.select((value) => value.error));
    final title = ref.watch(provider.select((value) => value.roomInfo?.title));

    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) {
      return _LiveRoomError(
        error: error,
        onRetry: () => ref.read(liveRoomControllerProvider(roomId).notifier).refresh(),
      );
    }

    return Column(
      children: [
        _LiveRoomTitle(title: title),
        Expanded(child: _DanmakuSection(roomId: roomId)),
      ],
    );
  }
}

class _LiveRoomTitle extends StatelessWidget {
  const _LiveRoomTitle({required this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (title == null || title!.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title!,
        style: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 19,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _DanmakuSection extends ConsumerWidget {
  const _DanmakuSection({required this.roomId});

  final int roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(liveDanmakuFeedProvider(roomId));
    final history = feed.items;

    return Stack(
      children: [
        if (feed.isEnabled)
          LiveDanmakuView(history: history)
        else
          const SizedBox.expand(),
        const _DanmakuTopGradient(),
      ],
    );
  }
}

class _DanmakuTopGradient extends StatelessWidget {
  const _DanmakuTopGradient();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 32,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [colorScheme.scrim, colorScheme.scrim.withValues(alpha: 0)],
            ),
          ),
        ),
      ),
    );
  }
}

class _LiveRoomError extends StatelessWidget {
  const _LiveRoomError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppErrorWidget(error: error, onRetry: onRetry),
    );
  }
}
