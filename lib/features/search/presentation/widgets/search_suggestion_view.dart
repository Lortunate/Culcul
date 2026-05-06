import 'package:culcul/features/search/presentation/view_models/search_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'search_suggestion_view.list.dart';
part 'search_suggestion_view.states.dart';

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
