import 'package:culcul/core/responsive/responsive.dart';
import 'package:flutter/material.dart';

class HomeGridLayoutSpec {
  const HomeGridLayoutSpec({
    required this.padding,
    required this.gridDelegate,
    required this.skeletonCount,
  });

  final EdgeInsets padding;
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;
  final int skeletonCount;

  factory HomeGridLayoutSpec.live(BuildContext context) {
    final columns = context.homeGridColumns;
    final isDesktop = context.isDesktopLayout;
    return HomeGridLayoutSpec(
      padding: EdgeInsets.all(isDesktop ? 12 : 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: isDesktop ? 10 : 6,
        crossAxisSpacing: isDesktop ? 10 : 6,
        childAspectRatio: isDesktop ? 1.12 : 1.1,
      ),
      skeletonCount: columns * 3,
    );
  }

  factory HomeGridLayoutSpec.recommend(BuildContext context) {
    final columns = context.homeGridColumns;
    final isDesktop = context.isDesktopLayout;
    return HomeGridLayoutSpec(
      padding: EdgeInsets.all(isDesktop ? 12 : 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: isDesktop ? 10 : 6,
        crossAxisSpacing: isDesktop ? 10 : 6,
        childAspectRatio: isDesktop ? 0.98 : 0.94,
      ),
      skeletonCount: columns * 4,
    );
  }
}

class HomePopularLayoutSpec {
  const HomePopularLayoutSpec({
    required this.padding,
    required this.itemGap,
    required this.cardHeight,
    required this.thumbnailWidth,
    required this.skeletonItemPadding,
  });

  final EdgeInsets padding;
  final double itemGap;
  final double cardHeight;
  final double thumbnailWidth;
  final EdgeInsetsGeometry skeletonItemPadding;

  factory HomePopularLayoutSpec.fromContext(BuildContext context) {
    final isDesktop = context.isDesktopLayout;
    return HomePopularLayoutSpec(
      padding: EdgeInsets.all(isDesktop ? 8 : 4),
      itemGap: isDesktop ? 8 : 4,
      cardHeight: isDesktop ? 112 : 100,
      thumbnailWidth: isDesktop ? 188 : 160,
      skeletonItemPadding: EdgeInsets.symmetric(vertical: isDesktop ? 4 : 2),
    );
  }
}
