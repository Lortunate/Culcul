import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/favorites/data/fav_repository_impl.dart';
import 'package:culcul/features/favorites/state/favorites_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<bool?> showVideoFavoritePicker({
  required BuildContext context,
  required int aid,
  required VoidCallback onLogin,
}) {
  final container = ProviderScope.containerOf(context, listen: false);
  final session = container.read(currentUserProvider);
  if (session == null || !session.isLoggedIn) {
    onLogin();
    return Future<bool?>.value();
  }

  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _VideoFavoritePickerSheet(aid: aid),
  );
}

class _VideoFavoritePickerSheet extends ConsumerStatefulWidget {
  const _VideoFavoritePickerSheet({required this.aid});

  final int aid;

  @override
  ConsumerState<_VideoFavoritePickerSheet> createState() =>
      _VideoFavoritePickerSheetState();
}

class _VideoFavoritePickerSheetState extends ConsumerState<_VideoFavoritePickerSheet> {
  Set<int> _initialSelectedIds = <int>{};
  Set<int> _selectedIds = <int>{};
  Object? _submitError;
  bool _selectionInitialized = false;
  bool _isSaving = false;

  Future<void> _submit() async {
    final addMediaIds = _selectedIds.difference(_initialSelectedIds);
    final delMediaIds = _initialSelectedIds.difference(_selectedIds);
    final isFavorite = _selectedIds.isNotEmpty;
    final hasChanges = addMediaIds.isNotEmpty || delMediaIds.isNotEmpty;
    if (!hasChanges) {
      Navigator.of(context).pop(isFavorite);
      return;
    }

    setState(() {
      _isSaving = true;
      _submitError = null;
    });

    final result = await ref
        .read(favRepositoryProvider)
        .dealVideoFavorite(
          aid: widget.aid,
          addMediaIds: addMediaIds,
          delMediaIds: delMediaIds,
        );

    if (!mounted) {
      return;
    }

    result.when(
      success: (_) => Navigator.of(context).pop(isFavorite),
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
            error: (error, _) => AppErrorWidget(
              error: error,
              onRetry: () {
                setState(() {
                  _selectionInitialized = false;
                  _initialSelectedIds = <int>{};
                  _selectedIds = <int>{};
                  _submitError = null;
                });
                ref.invalidate(videoFavoriteFoldersProvider(widget.aid));
              },
              variant: AppErrorWidgetVariant.compact,
            ),
            data: (folders) {
              if (!_selectionInitialized) {
                _initialSelectedIds = folders
                    .where((folder) => folder.favState == 1)
                    .map((folder) => folder.id)
                    .toSet();
                _selectedIds = Set<int>.of(_initialSelectedIds);
                _selectionInitialized = true;
              }

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
                                    : (selected) {
                                        setState(() {
                                          final next = Set<int>.of(_selectedIds);
                                          if (selected ?? false) {
                                            next.add(folder.id);
                                          } else {
                                            next.remove(folder.id);
                                          }
                                          _selectedIds = next;
                                          _submitError = null;
                                        });
                                      },
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
