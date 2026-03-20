import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/features/favorites/logic/fav_provider.dart';
import 'package:culcul/features/favorites/presentation/fav_resource_item.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_dialog.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final provider = favFolderResourcesProvider(mediaId);
    final asyncValue = ref.watch(provider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final authState = ref.watch(authProvider);

    final isMine = authState.isLoggedIn && authState.user?.id == mid.toString();
    final isSelectionMode = useState(false);
    final selectedItems = useState<Set<int>>({});

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (isSelectionMode.value) ...[
            TextButton(
              onPressed: selectedItems.value.isEmpty
                  ? null
                  : () async {
                      // Batch delete
                      final resources = selectedItems.value.join(',');
                      try {
                        await ref
                            .read(favRepositoryProvider)
                            .batchDelResource(
                              resources: resources,
                              mediaId: mediaId,
                            );
                        isSelectionMode.value = false;
                        selectedItems.value = {};
                        ref.invalidate(provider);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to delete: $e')),
                          );
                        }
                      }
                    },
              child: Text('Delete (${selectedItems.value.length})'),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                isSelectionMode.value = false;
                selectedItems.value = {};
              },
            ),
          ] else if (isMine)
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'edit') {
                  final createdFolders = ref
                      .read(favCreatedFoldersProvider)
                      .asData
                      ?.value;
                  final folder = createdFolders
                      ?.where((f) => f.id == mediaId)
                      .firstOrNull;

                  final result = await showDialog<Map<String, dynamic>>(
                    context: context,
                    builder: (_) => FavFolderDialog(folder: folder),
                  );

                  if (result != null) {
                    try {
                      await ref
                          .read(favRepositoryProvider)
                          .editFolder(
                            mediaId: mediaId,
                            title: result['title']! as String,
                            intro: result['intro'] as String?,
                            privacy: result['privacy'] as int?,
                          );
                      ref.invalidate(favCreatedFoldersProvider);
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to edit: $e')),
                        );
                      }
                    }
                  }
                } else if (value == 'manage') {
                  isSelectionMode.value = true;
                } else if (value == 'delete') {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Folder'),
                      content: const Text(
                        'Are you sure you want to delete this folder?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    try {
                      await ref
                          .read(favRepositoryProvider)
                          .delFolder(mediaIds: mediaId.toString());
                      ref.invalidate(favCreatedFoldersProvider);
                      if (context.mounted) {
                        context.pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to delete: $e')),
                        );
                      }
                    }
                  }
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit Info')),
                const PopupMenuItem(
                  value: 'manage',
                  child: Text('Manage Resources'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    'Delete Folder',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
        ],
      ),
      body: asyncValue.when(
        data: (state) {
          final items = state.list;
          final info = state.info;

          return EasyRefresh(
            header: AppRefreshHeader(),
            footer: AppLoadFooter(),
            onRefresh: () async {
              return ref.refresh(provider.future);
            },
            onLoad: () async {
              await ref.read(provider.notifier).loadMore(mediaId);
            },
            child: CustomScrollView(
              slivers: [
                if (info != null)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AppNetworkImage(
                              url: info.cover,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  info.title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    ClipOval(
                                      child: AppNetworkImage(
                                        url: info.upper.face,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      info.upper.name,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${info.mediaCount} resources',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (items.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: AppErrorWidget(
                        message: 'No content',
                        onRetry: () => ref.refresh(provider.future),
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = items[index];
                      return Column(
                        children: [
                          Row(
                            children: [
                              if (isSelectionMode.value)
                                Checkbox(
                                  value: selectedItems.value.contains(item.id),
                                  onChanged: (value) {
                                    final newSet = Set<int>.from(
                                      selectedItems.value,
                                    );
                                    if (value == true) {
                                      newSet.add(item.id);
                                    } else {
                                      newSet.remove(item.id);
                                    }
                                    selectedItems.value = newSet;
                                  },
                                ),
                              Expanded(
                                child: FavResourceItem(
                                  item: item,
                                  onTap: () {
                                    if (isSelectionMode.value) {
                                      final newSet = Set<int>.from(
                                        selectedItems.value,
                                      );
                                      if (newSet.contains(item.id)) {
                                        newSet.remove(item.id);
                                      } else {
                                        newSet.add(item.id);
                                      }
                                      selectedItems.value = newSet;
                                    } else {
                                      // TODO: Navigate to video detail
                                      // context.push('/video/${item.bvid}');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                        ],
                      );
                    }, childCount: items.length),
                  ),
              ],
            ),
          );
        },
        error: (error, stack) => Center(
          child: AppErrorWidget(
            error: error,
            stackTrace: stack,
            onRetry: () => ref.refresh(provider.future),
          ),
        ),
        loading: () => const _Skeleton(),
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: 10,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (context, index) {
        return AppShimmer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 160,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 16, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(height: 16, width: 100, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
