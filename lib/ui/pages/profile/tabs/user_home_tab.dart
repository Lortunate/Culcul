import 'package:culcul/ui/pages/profile/widgets/home_tab/masterpiece_section.dart';
import 'package:culcul/ui/pages/profile/widgets/home_tab/recent_video_section.dart';
import 'package:culcul/ui/pages/profile/widgets/home_tab/sticky_video_section.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserHomeTab extends ConsumerStatefulWidget {
  final int mid;
  final ValueChanged<int>? onSwitchToTab;

  const UserHomeTab({super.key, required this.mid, this.onSwitchToTab});

  @override
  ConsumerState<UserHomeTab> createState() => _UserHomeTabState();
}

class _UserHomeTabState extends ConsumerState<UserHomeTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      key: PageStorageKey<String>('user_home_tab_${widget.mid}'),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 12),
          sliver: StickyVideoSection(mid: widget.mid),
        ),
        MasterpieceSection(mid: widget.mid),
        RecentVideoSection(
          mid: widget.mid,
          onSwitchToTab: widget.onSwitchToTab,
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.paddingOf(context).bottom + 24),
        ),
      ],
    );
  }
}
