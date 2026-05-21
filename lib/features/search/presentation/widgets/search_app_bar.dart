import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;
  final VoidCallback onClear;
  final ValueChanged<String> onSearch;

  const SearchAppBar({
    super.key,
    required this.controller,
    required this.focusNode,
    this.hintText,
    required this.onClear,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Container(
        height: 36,
        margin: const EdgeInsets.only(left: CulculSpacing.xs, right: CulculSpacing.xxs),
        decoration: BoxDecoration(
          color:
              theme.inputDecorationTheme.fillColor ?? colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(CulculRadius.lg),
          border: Border.all(color: Colors.transparent, width: 0.0),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            Icon(Icons.search_rounded, size: 18, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: CulculSpacing.xs),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                textInputAction: TextInputAction.search,
                onSubmitted: onSearch,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: colorScheme.primary,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: colorScheme.onSurface,
                  height: 1.2,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hintText ?? t.search.placeholder,
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    fontSize: 13,
                    height: 1.2,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (controller.text.isNotEmpty) ...[
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                icon: Icon(
                  Icons.cancel,
                  size: 16,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
                onPressed: onClear,
              ),
              const SizedBox(width: CulculSpacing.xxs),
            ] else
              const SizedBox(width: 14),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: CulculSpacing.xs),
          child: TextButton(
            onPressed: () => onSearch(controller.text),
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(
                horizontal: CulculSpacing.md,
                vertical: CulculSpacing.xs,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: colorScheme.primary,
            ),
            child: Text(
              t.search.button,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
