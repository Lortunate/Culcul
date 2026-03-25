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

  BoxDecoration _buildDecoration(ThemeData theme) {
    return BoxDecoration(
      color:
          theme.inputDecorationTheme.fillColor ??
          theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(22),
    );
  }

  TextStyle? _buildTextStyle(ThemeData theme) {
    return theme.textTheme.bodyMedium?.copyWith(
      fontSize: 15,
      color: theme.colorScheme.onSurface,
    );
  }

  TextStyle? _buildHintStyle(ThemeData theme) {
    return theme.textTheme.bodyMedium?.copyWith(
      fontSize: 15,
      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
    );
  }

  Widget _buildSearchIcon(Color color) {
    return Icon(Icons.search_rounded, size: 20, color: color);
  }

  Widget _buildEditableSearchBar(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      height: 44,
      decoration: _buildDecoration(theme),
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        autofocus: autofocus,
        style: _buildTextStyle(theme),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          fillColor: Colors.transparent,
          hintText: hintText,
          hintStyle: _buildHintStyle(theme),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 8),
            child: _buildSearchIcon(colorScheme.onSurfaceVariant),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: suffixIcon,
          suffixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.only(right: 14),
        ),
        cursorColor: colorScheme.primary,
      ),
    );
  }

  Widget _buildReadonlySearchBar(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: _buildDecoration(theme),
        child: Row(
          children: [
            _buildSearchIcon(colorScheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                hintText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: _buildHintStyle(theme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (controller != null) {
      return _buildEditableSearchBar(context, theme);
    }

    return _buildReadonlySearchBar(context, theme);
  }
}

