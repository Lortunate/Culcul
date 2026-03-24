import 'package:flutter/material.dart';

class GridSkeletonView extends StatelessWidget {
  final Widget itemSkeleton;
  final int itemCount;
  final SliverGridDelegate gridDelegate;
  final EdgeInsetsGeometry padding;

  const GridSkeletonView({
    super.key,
    required this.itemSkeleton,
    this.itemCount = 10,
    required this.gridDelegate,
    this.padding = const EdgeInsets.all(8),
  });

  SliverChildBuilderDelegate _buildDelegate() {
    return SliverChildBuilderDelegate(
      (context, index) => itemSkeleton,
      childCount: itemCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverGrid(
            gridDelegate: gridDelegate,
            delegate: _buildDelegate(),
          ),
        ),
      ],
    );
  }
}

class ListSkeletonView extends StatelessWidget {
  final Widget itemSkeleton;
  final int itemCount;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry itemPadding;

  const ListSkeletonView({
    super.key,
    required this.itemSkeleton,
    this.itemCount = 10,
    this.padding = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 8),
  });

  SliverChildBuilderDelegate _buildDelegate() {
    return SliverChildBuilderDelegate(
      (context, index) => Padding(
        padding: itemPadding,
        child: itemSkeleton,
      ),
      childCount: itemCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverList(
            delegate: _buildDelegate(),
          ),
        ),
      ],
    );
  }
}
