import 'package:culcul/features/search/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchSuggestionView extends HookConsumerWidget {
  final String term;
  final ValueChanged<String> onSuggestionTap;

  const SearchSuggestionView({
    super.key,
    required this.term,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (term.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final suggestionAsync = ref.watch(searchSuggestionsProvider(term));

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: suggestionAsync.when(
        data: (suggestions) {
          if (suggestions.isEmpty) {
            return _EmptyState(colorScheme: colorScheme, theme: theme);
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              final displayValue = suggestion.value ?? suggestion.term ?? '';
              if (displayValue.isEmpty) return const SizedBox.shrink();

              return _AnimatedSuggestionItem(
                index: index,
                displayValue: displayValue,
                term: term,
                onTap: () => onSuggestionTap(displayValue),
              );
            },
          );
        },
        loading: () => const _LoadingState(),
        error: (error, _) =>
            _ErrorState(colorScheme: colorScheme, theme: theme),
      ),
    );
  }

  static List<TextSpan> _buildHighlightedSpans(
    String text,
    String searchTerm,
    TextStyle normalStyle,
    TextStyle highlightStyle,
  ) {
    if (searchTerm.isEmpty) {
      return [TextSpan(text: text, style: normalStyle)];
    }

    final spans = <TextSpan>[];
    final lowerText = text.toLowerCase();
    final lowerSearchTerm = searchTerm.toLowerCase();
    int currentIndex = 0;

    while (currentIndex < text.length) {
      final matchIndex = lowerText.indexOf(lowerSearchTerm, currentIndex);

      if (matchIndex == -1) {
        spans.add(
          TextSpan(text: text.substring(currentIndex), style: normalStyle),
        );
        break;
      }

      if (matchIndex > currentIndex) {
        spans.add(
          TextSpan(
            text: text.substring(currentIndex, matchIndex),
            style: normalStyle,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: text.substring(matchIndex, matchIndex + searchTerm.length),
          style: highlightStyle,
        ),
      );

      currentIndex = matchIndex + searchTerm.length;
    }

    return spans;
  }
}

class _AnimatedSuggestionItem extends HookWidget {
  final int index;
  final String displayValue;
  final String term;
  final VoidCallback onTap;

  const _AnimatedSuggestionItem({
    required this.index,
    required this.displayValue,
    required this.term,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final controller = useAnimationController(
      duration: const Duration(milliseconds: 350),
    );

    useEffect(() {
      controller.forward();
      return null;
    }, []);

    final startDelay = (index * 0.04).clamp(0.0, 0.4);

    final fadeAnimation = useAnimation(
      CurvedAnimation(
        parent: controller,
        curve: Interval(startDelay, 1.0, curve: Curves.easeOut),
      ),
    );

    final slideAnimation = useAnimation(
      Tween<Offset>(begin: const Offset(0.02, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(startDelay, 1.0, curve: Curves.easeOutQuad),
        ),
      ),
    );

    final normalStyle = theme.textTheme.bodyLarge?.copyWith(
      fontSize: 16,
      color: colorScheme.onSurface.withValues(alpha: 0.8),
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
    );
    final highlightStyle = theme.textTheme.bodyLarge?.copyWith(
      fontSize: 16,
      color: colorScheme.primary,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    );

    return Opacity(
      opacity: fadeAnimation,
      child: Transform.translate(
        offset: slideAnimation,
        child: InkWell(
          onTap: onTap,
          splashColor: colorScheme.primary.withValues(alpha: 0.05),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: SearchSuggestionView._buildHighlightedSpans(
                        displayValue,
                        term,
                        normalStyle ?? const TextStyle(),
                        highlightStyle ?? const TextStyle(),
                      ),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.north_west_rounded,
                  size: 16,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(height: 16),
          Text(
            '正在获取建议...',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _EmptyState({required this.colorScheme, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bubble_chart_rounded,
            size: 56,
            color: colorScheme.primary.withValues(alpha: 0.1),
          ),
          const SizedBox(height: 16),
          Text(
            '未发现相关搜索建议',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _ErrorState({required this.colorScheme, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.wifi_off_rounded,
              size: 24,
              color: colorScheme.error.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '获取建议失败',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
