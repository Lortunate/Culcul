import 'package:culcul/features/search/application/search_application_providers.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
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
                    t.search.status.empty,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          final nonEmptySuggestions = suggestions
              .where((entry) => entry.isNotEmpty)
              .toList(growable: false);

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(0, 0.03),
                end: Offset.zero,
              ).animate(animation);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: offsetAnimation, child: child),
              );
            },
            child: ListView.builder(
              key: ValueKey('suggestions_${term}_len_${nonEmptySuggestions.length}'),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: nonEmptySuggestions.length,
              itemBuilder: (context, index) {
                final displayValue = nonEmptySuggestions[index];
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

                return InkWell(
                  key: ValueKey('search_suggestion_${displayValue}_$index'),
                  onTap: () => onSuggestionTap(displayValue),
                  splashColor: colorScheme.primary.withValues(alpha: 0.05),
                  highlightColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: _buildHighlightedSpans(
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
                );
              },
            ),
          );
        },
        loading: () => Center(
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
                t.search.status.loading,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
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
