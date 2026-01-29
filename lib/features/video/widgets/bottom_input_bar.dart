import 'package:cilixili/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class BottomInputBar extends StatelessWidget {
  final VoidCallback? onTapInput;
  final VoidCallback? onTapLike;
  final VoidCallback? onTapCoin;
  final VoidCallback? onTapStar;
  final VoidCallback? onTapShare;

  const BottomInputBar({
    super.key,
    this.onTapInput,
    this.onTapLike,
    this.onTapCoin,
    this.onTapStar,
    this.onTapShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final t = Translations.of(context);

    final borderColor = isDark
        ? const Color(0xFF2C2C2E)
        : const Color(0xFFE3E5E7);
    final inputBgColor = isDark
        ? const Color(0xFF2C2C2E)
        : const Color(0xFFF1F2F3);
    final placeholderColor = isDark
        ? const Color(0xFF757575)
        : const Color(0xFF9499A0);
    final iconColor = isDark
        ? const Color(0xFFE5E5E5)
        : const Color(0xFF61666D);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: borderColor, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onTapInput,
                child: Container(
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: inputBgColor,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        size: 14,
                        color: placeholderColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        t.video.comment_hint,
                        style: TextStyle(color: placeholderColor, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            _ActionIcon(
              icon: Icons.thumb_up_outlined,
              onTap: onTapLike,
              color: iconColor,
            ),
            _ActionIcon(
              icon: Icons.star_outline_rounded,
              onTap: onTapStar,
              color: iconColor,
            ),
            _ActionIcon(
              icon: Icons.share_outlined,
              onTap: onTapShare,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color color;

  const _ActionIcon({required this.icon, this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, size: 24, color: color),
        ),
      ),
    );
  }
}
