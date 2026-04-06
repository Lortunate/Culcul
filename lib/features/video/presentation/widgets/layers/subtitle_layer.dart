import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/subtitle_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubtitleLayer extends HookConsumerWidget {
  final String bvid;

  const SubtitleLayer({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final subtitleState = ref.watch(subtitleControllerProvider(bvid));
    final player = ref.read(playerControllerProvider.notifier).player;
    final subtitleCursorRef = useRef<int>(0);
    final activeSubtitle = useState<SubtitleItem?>(null);

    useEffect(() {
      if (!subtitleState.isEnabled || subtitleState.content.isEmpty) {
        subtitleCursorRef.value = 0;
        if (activeSubtitle.value != null) {
          activeSubtitle.value = null;
        }
        return null;
      }

      void refreshSubtitle(Duration position) {
        final currentSeconds = position.inMilliseconds / 1000.0;
        final subtitleIndex = _resolveSubtitleIndex(
          subtitleState.content,
          currentSeconds,
          subtitleCursorRef.value,
        );
        if (subtitleIndex < 0) {
          if (activeSubtitle.value != null) {
            activeSubtitle.value = null;
          }
          return;
        }
        if (subtitleIndex == subtitleCursorRef.value &&
            activeSubtitle.value?.content ==
                subtitleState.content[subtitleIndex].content) {
          return;
        }
        subtitleCursorRef.value = subtitleIndex;
        activeSubtitle.value = subtitleState.content[subtitleIndex];
      }

      refreshSubtitle(player.state.position);
      final subscription = player.stream.position.listen(refreshSubtitle);
      return subscription.cancel;
    }, [player, subtitleState.content, subtitleState.isEnabled]);

    if (!subtitleState.isEnabled || subtitleState.content.isEmpty) {
      return const SizedBox();
    }

    final currentItem = activeSubtitle.value;
    if (currentItem == null) {
      return const SizedBox();
    }

    return RepaintBoundary(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.scrim.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              currentItem.content,
              textAlign: TextAlign.center,
              style: PlayerTheme.subtitleStyle(colorScheme),
            ),
          ),
        ),
      ),
    );
  }
}

int _resolveSubtitleIndex(List<SubtitleItem> items, double target, int previousIndex) {
  if (items.isEmpty) {
    return -1;
  }

  if (_containsSubtitle(items, previousIndex, target)) {
    return previousIndex;
  }
  if (_containsSubtitle(items, previousIndex + 1, target)) {
    return previousIndex + 1;
  }
  if (_containsSubtitle(items, previousIndex - 1, target)) {
    return previousIndex - 1;
  }

  return _findSubtitleIndexBinary(items, target);
}

bool _containsSubtitle(List<SubtitleItem> items, int index, double target) {
  if (index < 0 || index >= items.length) {
    return false;
  }
  final item = items[index];
  return item.from <= target && item.to >= target;
}

int _findSubtitleIndexBinary(List<SubtitleItem> items, double target) {
  var left = 0;
  var right = items.length - 1;

  while (left <= right) {
    final mid = left + ((right - left) ~/ 2);
    final item = items[mid];
    if (target < item.from) {
      right = mid - 1;
    } else if (target > item.to) {
      left = mid + 1;
    } else {
      return mid;
    }
  }
  return -1;
}
