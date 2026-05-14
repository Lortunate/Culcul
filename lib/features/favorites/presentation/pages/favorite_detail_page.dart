import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/data/fav_repository_impl.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_dialog.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_resource_item.dart';
import 'package:culcul/features/favorites/presentation/view_models/favorites_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'favorite_detail_page.list_section.dart';
part 'favorite_detail_page.list_rows.dart';
part 'favorite_detail_page.list_skeleton.dart';
part 'favorite_detail_page.toolbar_actions.dart';

class FavoriteDetailPage extends HookConsumerWidget {
  final int mediaId;
  final String title;
  final int mid;

  const FavoriteDetailPage({
    super.key,
    required this.mediaId,
    required this.title,
    required this.mid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final session = ref.watch(currentUserProvider);
    final isMine = session != null && session.isLoggedIn && session.uid == mid.toString();

    final isSelectionMode = useState(false);
    final selectedItems = useState<Set<int>>({});
    final refreshController = useManagedEasyRefreshController();
    final loadGate = useMemoized(PaginationLoadGate.new, [mediaId]);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: _buildFavoriteDetailAppBarActions(
          context: context,
          ref: ref,
          mediaId: mediaId,
          isMine: isMine,
          isSelectionMode: isSelectionMode,
          selectedItems: selectedItems,
        ),
      ),
      body: _FavoriteDetailListSection(
        mediaId: mediaId,
        refreshController: refreshController,
        loadGate: loadGate,
        isSelectionMode: isSelectionMode,
        selectedItems: selectedItems,
      ),
    );
  }
}
