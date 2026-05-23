import 'package:culcul/features/favorites/application/video_favorite_selection.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/presentation/view_models/favorites_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoFavoritePickerSheet extends ConsumerStatefulWidget {
  const VideoFavoritePickerSheet({super.key, required this.aid});

  final int aid;

  @override
  ConsumerState<VideoFavoritePickerSheet> createState() =>
      _VideoFavoritePickerSheetState();
}

class _VideoFavoritePickerSheetState extends ConsumerState<VideoFavoritePickerSheet> {
  Set<int> _initialSelectedIds = <int>{};
  Set<int> _selectedIds = <int>{};
  Object? _submitError;
  bool _selectionInitialized = false;
  bool _isSaving = false;

  void _retry() {
    setState(() {
      _selectionInitialized = false;
      _initialSelectedIds = <int>{};
      _selectedIds = <int>{};
      _submitError = null;
    });
    ref.invalidate(videoFavoriteFoldersProvider(widget.aid));
  }

  void _initializeSelection(List<FavoriteFolder> folders) {
    if (_selectionInitialized) {
      return;
    }
    _initialSelectedIds = selectedVideoFavoriteFolderIds(folders);
    _selectedIds = Set<int>.of(_initialSelectedIds);
    _selectionInitialized = true;
  }

  void _toggleFolder(int mediaId, bool selected) {
    setState(() {
      final next = Set<int>.of(_selectedIds);
      if (selected) {
        next.add(mediaId);
      } else {
        next.remove(mediaId);
      }
      _selectedIds = next;
      _submitError = null;
    });
  }

  Future<void> _submit() async {
    final delta = buildVideoFavoriteFolderDelta(
      initialIds: _initialSelectedIds,
      selectedIds: _selectedIds,
    );
    if (!delta.hasChanges) {
      Navigator.of(context).pop(delta.isFavorite);
      return;
    }

    setState(() {
      _isSaving = true;
      _submitError = null;
    });

    final result = await ref
        .read(videoFavoriteCommandsProvider)
        .dealVideoFavorite(
          aid: widget.aid,
          addMediaIds: delta.addMediaIds,
          delMediaIds: delta.delMediaIds,
        );

    if (!mounted) {
      return;
    }

    result.when(
      success: (_) => Navigator.of(context).pop(delta.isFavorite),
      failure: (error) {
        setState(() {
          _isSaving = false;
          _submitError = error;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final foldersAsync = ref.watch(videoFavoriteFoldersProvider(widget.aid));

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.viewInsetsOf(context).bottom + 12,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.72,
          ),
          child: foldersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) =>
                AppErrorWidget(error: error, onRetry: _retry, compact: true),
            data: (folders) {
              _initializeSelection(folders);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          t.favorites.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: folders.isEmpty
                        ? Center(
                            child: Icon(
                              Icons.folder_open_rounded,
                              size: 42,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: folders.length,
                            itemBuilder: (context, index) {
                              final folder = folders[index];
                              return CheckboxListTile(
                                value: _selectedIds.contains(folder.id),
                                onChanged: _isSaving
                                    ? null
                                    : (selected) =>
                                          _toggleFolder(folder.id, selected ?? false),
                                title: Text(
                                  folder.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  t.favorites.folder_item_count(count: folder.mediaCount),
                                ),
                                secondary: Icon(
                                  folder.isPrivate
                                      ? Icons.lock_outline_rounded
                                      : Icons.folder_outlined,
                                ),
                                controlAffinity: ListTileControlAffinity.leading,
                              );
                            },
                          ),
                  ),
                  if (_submitError != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _submitError.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
                        child: Text(t.common.cancel),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: _isSaving || folders.isEmpty ? null : _submit,
                        child: _isSaving
                            ? const SizedBox.square(
                                dimension: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(t.common.confirm),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
