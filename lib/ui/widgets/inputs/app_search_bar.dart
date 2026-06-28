import 'package:culcul/core/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;

  const AppSearchBar({
    super.key,
    this.onTap,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final decoration = BoxDecoration(
      color:
          theme.inputDecorationTheme.fillColor ??
          theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(CulculRadius.lg),
    );
    final hintStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: 15,
      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
    );

    if (controller != null) {
      return Container(
        height: 40,
        decoration: decoration,
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
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
            hintStyle: hintStyle,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: CulculSpacing.md,
                right: CulculSpacing.xs,
              ),
              child: Icon(
                Icons.search_rounded,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.only(right: CulculSpacing.md),
          ),
          cursorColor: colorScheme.primary,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(CulculRadius.lg),
      child: AppClickable(
        onTap: onTap,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: CulculSpacing.md),
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
                  style: hintStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
