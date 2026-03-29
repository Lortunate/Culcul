import 'package:flutter/material.dart';

class HomeTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController? controller;
  final List<String> tabs;
  final ValueChanged<int>? onTap;

  const HomeTabBar({super.key, this.controller, required this.tabs, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        onTap: onTap,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.2,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          height: 1.2,
          letterSpacing: 0.2,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: _FixedSizeIndicator(
          color: colorScheme.primary,
          width: 16,
          height: 3,
          radius: 1.5,
          bottomOffset: 4,
        ),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        dividerColor: Colors.transparent,
        tabs: tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}

class _FixedSizeIndicator extends Decoration {
  final Color color;
  final double width;
  final double height;
  final double radius;
  final double bottomOffset;

  const _FixedSizeIndicator({
    required this.color,
    required this.width,
    required this.height,
    required this.radius,
    required this.bottomOffset,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FixedSizePainter(this, onChanged);
  }
}

class _FixedSizePainter extends BoxPainter {
  final _FixedSizeIndicator decoration;

  _FixedSizePainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint()
      ..color = decoration.color
      ..style = PaintingStyle.fill;

    final double dx = rect.center.dx - decoration.width / 2;
    final double dy = rect.bottom - decoration.height - decoration.bottomOffset;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(dx, dy, decoration.width, decoration.height),
      Radius.circular(decoration.radius),
    );

    canvas.drawRRect(rRect, paint);
  }
}
