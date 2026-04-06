import 'package:culcul/features/search/presentation/view_models/search_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
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
    final t = Translations.of(context);
    final suggestionAsync = ref.watch(searchSuggestionsProvider(term));

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: suggestionAsync.when(
        data: (suggestions) {
          if (suggestions.isEmpty) {
            return _EmptyState(colorScheme: colorScheme, theme: theme);
          }

          final nonEmptySuggestions = suggestions
              .map((entry) => entry.value)
              .where((value) => value.isNotEmpty)
              .toList(growable: false);

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _SuggestionList(
              key: ValueKey('suggestions_${term}_len_${nonEmptySuggestions.length}'),
              term: term,
              suggestions: nonEmptySuggestions,
              onSuggestionTap: onSuggestionTap,
            ),
          );
        },
        loading: () => _LoadingState(text: t.search.status.loading),
        error: (error, stack) => AppErrorWidget(
          error: error,
          stackTrace: stack,
          onRetry: () => ref.refresh(searchSuggestionsProvider(term)),
          variant: AppErrorWidgetVariant.compact,
        ),
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
        spans.add(TextSpan(text: text.substring(currentIndex), style: normalStyle));
        break;
      }

      if (matchIndex > currentIndex) {
        spans.add(
          TextSpan(text: text.substring(currentIndex, matchIndex), style: normalStyle),
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

class _SuggestionList extends StatelessWidget {
  final List<String> suggestions;
  final String term;
  final ValueChanged<String> onSuggestionTap;

  const _SuggestionList({
    super.key,
    required this.suggestions,
    required this.term,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final displayValue = suggestions[index];
        return _SuggestionItem(
          key: ValueKey('search_suggestion_${displayValue}_$index'),
          index: index,
          displayValue: displayValue,
          term: term,
          onTap: () => onSuggestionTap(displayValue),
        );
      },
    );
  }
}

class _SuggestionItem extends StatelessWidget {
  final int index;
  final String displayValue;
  final String term;
  final VoidCallback onTap;

  const _SuggestionItem({
    super.key,
    required this.index,
    required this.displayValue,
    required this.term,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 150 + index * 10),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        final dy = (1 - value) * 6;
        return Opacity(
          opacity: value,
          child: Transform.translate(offset: Offset(0, dy), child: child),
        );
      },
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
    );
  }
}

class _LoadingState extends StatelessWidget {
  final String text;

  const _LoadingState({required this.text});

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
            text,
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
            Translations.of(context).search.status.empty,
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
