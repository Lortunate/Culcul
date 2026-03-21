import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final Widget? suffixIcon;

  const AppSearchBar({
    super.key,
    this.onTap,
    this.hintText = 'Search videos...',
    this.controller,
    this.onChanged,
    this.autofocus = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final decoration = BoxDecoration(
      color: theme.inputDecorationTheme.fillColor ?? colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(22),
    );

    if (controller != null) {
      return Container(
        height: 44,
        decoration: decoration,
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          autofocus: autofocus,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 15,
            color: colorScheme.onSurface,
          ),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            filled: false,
            fillColor: Colors.transparent,
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 15,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 14, right: 8),
              child: Icon(
                Icons.search_rounded,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.only(right: 14),
          ),
          cursorColor: theme.colorScheme.primary,
        ),
      );
    }

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: decoration,
        child: Row(
          children: [
            Icon(Icons.search_rounded, size: 20, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                hintText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
