part of 'search_suggestion_view.dart';

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
          displayValue: displayValue,
          term: term,
          onTap: () => onSuggestionTap(displayValue),
        );
      },
    );
  }
}

class _SuggestionItem extends StatelessWidget {
  final String displayValue;
  final String term;
  final VoidCallback onTap;

  const _SuggestionItem({
    super.key,
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

    return InkWell(
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
    );
  }
}
