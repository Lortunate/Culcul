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
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: colorScheme.scrim,
        border: Border(
          top: BorderSide(
            color: colorScheme.onPrimary.withValues(alpha: 0.04),
            width: 0.8,
          ),
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
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '弹幕支持下~',
                          style: TextStyle(
                            color: colorScheme.onPrimary.withValues(alpha: 0.42),
                            fontSize: 13,
                            height: 1.1,
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
            // const SizedBox(width: 10),
            // _buildIconButton(
            //   context,
            //   icon: Icons.shopping_bag_outlined, // Shop/Bag
            //   onPressed: () {},
            // ),
            // _buildIconButton(
            //   context,
            //   icon: Icons.local_florist_rounded, // Rose/Flower
            //   color: colorScheme.primary,
            //   onPressed: () {},
            // ),
            // _buildIconButton(
            //   context,
            //   icon: Icons.card_giftcard_rounded, // Gift Box
            //   color: colorScheme.primary,
            //   onPressed: onGift,
            // ),
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
      color: color ?? Theme.of(context).colorScheme.onPrimary,
      iconSize: 24,
      constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
      padding: EdgeInsets.zero,
    );
  }
}
