import 'package:flutter/material.dart';

class LiveBottomBar extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onTapInput;
  final VoidCallback? onGift;
  final VoidCallback? onShare;
  final VoidCallback? onLike;

  const LiveBottomBar({
    super.key,
    this.controller,
    this.onTapInput,
    this.onGift,
    this.onShare,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black, // Force black background
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05), width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onTapInput,
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '弹幕支持下~',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.4),
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            _buildIconButton(
              context,
              icon: Icons.shopping_bag_outlined, // Shop/Bag
              onPressed: () {},
            ),
            _buildIconButton(
              context,
              icon: Icons.local_florist_rounded, // Rose/Flower
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
            ),
            _buildIconButton(
              context,
              icon: Icons.card_giftcard_rounded, // Gift Box
              color: Theme.of(context).colorScheme.primary,
              onPressed: onGift,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    Color? color,
    VoidCallback? onPressed,
  }) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed ?? () {},
      color: color ?? Colors.white,
      iconSize: 26, // Slightly larger
      constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
      padding: EdgeInsets.zero,
    );
  }
}
