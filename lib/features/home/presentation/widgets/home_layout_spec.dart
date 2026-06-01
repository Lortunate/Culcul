import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:flutter/material.dart';

const double homeFeedMaxWidth = 1280;
const double homePopularMaxWidth = 980;

extension HomeResponsive on BuildContext {
  int get homeGridColumns {
    if (screenWidth >= AppBreakpoints.xlStart) {
      return 5;
    }
    if (screenWidth >= AppBreakpoints.desktopStart) {
      return 4;
    }
    if (screenWidth >= AppBreakpoints.tabletStart) {
      return 3;
    }
    return 2;
  }
}

class HomeGridLayoutSpec {
  const HomeGridLayoutSpec({
    required this.padding,
    required this.gridDelegate,
    required this.skeletonCount,
    required this.cacheExtent,
  });

  final EdgeInsets padding;
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;
  final int skeletonCount;
  final double cacheExtent;

  factory HomeGridLayoutSpec.live(BuildContext context) {
    final columns = context.homeGridColumns;
    final isDesktop = context.isDesktopLayout;
    return HomeGridLayoutSpec(
      padding: EdgeInsets.all(isDesktop ? 12 : 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: isDesktop ? 10 : 6,
        crossAxisSpacing: isDesktop ? 10 : 6,
        childAspectRatio: isDesktop ? 1.02 : 0.98,
      ),
      skeletonCount: columns * 3,
      cacheExtent: isDesktop ? 1100 : 640,
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
      cacheExtent: isDesktop ? 1200 : 720,
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
    required this.cacheExtent,
  });

  final EdgeInsets padding;
  final double itemGap;
  final double cardHeight;
  final double thumbnailWidth;
  final EdgeInsetsGeometry skeletonItemPadding;
  final double cacheExtent;

  factory HomePopularLayoutSpec.fromContext(BuildContext context) {
    final isDesktop = context.isDesktopLayout;
    return HomePopularLayoutSpec(
      padding: EdgeInsets.all(isDesktop ? 8 : 4),
      itemGap: isDesktop ? 8 : 4,
      cardHeight: isDesktop ? 112 : 100,
      thumbnailWidth: isDesktop ? 188 : 160,
      skeletonItemPadding: EdgeInsets.symmetric(vertical: isDesktop ? 4 : 2),
      cacheExtent: isDesktop ? 960 : 560,
    );
  }
}
