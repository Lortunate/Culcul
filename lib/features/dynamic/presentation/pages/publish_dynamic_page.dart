import 'dart:async';
import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/dynamic/application/dynamic_feed_provider.dart';
import 'package:culcul/features/dynamic/application/models/emote_catalog.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/features/dynamic/data/emote_repository_impl.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_publish_command.dart';
import 'package:culcul/features/search/application/search_application_providers.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final _publishDynamicControllerProvider =
    NotifierProvider<_PublishDynamicController, bool>(_PublishDynamicController.new);

class _PublishDynamicController extends Notifier<bool> {
  @override
  bool build() => false;

  Future<String?> publish({required String content, required List<File> images}) async {
    final trimmed = content.trim();
    if (trimmed.isEmpty && images.isEmpty) return null;
    if (state) return null;

    state = true;

    final assets = images.map((f) => PublishMediaAsset(path: f.path)).toList();

    final result = await _publishDynamic(content: trimmed, images: assets);
    final error = result.when(
      success: (_) {
        ref.invalidate(dynamicProvider);
        return null;
      },
      failure: (error) => error.message,
    );
    state = false;
    return error;
  }

  Future<Result<void, AppError>> _publishDynamic({
    required String content,
    required List<PublishMediaAsset> images,
  }) async {
    final repository = ref.read(dynamicRepositoryProvider);
    return (await _resolveCsrf(repository)).when(
      success: (csrfToken) async {
        final uploadedImagesResult = await repository.uploadImagesWithCsrf(
          files: images,
          csrf: csrfToken,
        );
        return uploadedImagesResult.when(
          success: (images) => repository.publishDynamic(
            content: content,
            csrf: csrfToken,
            images: images,
          ),
          failure: (error) async => Failure(error),
        );
      },
      failure: (error) async => Failure(error),
    );
  }

  Future<Result<String, AppError>> _resolveCsrf(DynamicRepositoryImpl repository) async {
    final csrfResult = await repository.getPublishCsrf();
    final csrf = csrfResult.dataOrNull;
    if (csrf == null || csrf.isEmpty) {
      return Failure(csrfResult.errorOrNull ?? const AppError.auth('Missing csrf token'));
    }
    return Success(csrf);
  }
}

class PublishDynamicPage extends ConsumerStatefulWidget {
  const PublishDynamicPage({super.key});

  @override
  ConsumerState<PublishDynamicPage> createState() => _PublishDynamicPageState();
}

class _PublishDynamicPageState extends ConsumerState<PublishDynamicPage> {
  static const _maxImages = 9;

  final TextEditingController _controller = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final List<File> _images = [];
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _hasDraftNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasDraft = _controller.text.trim().isNotEmpty || _images.isNotEmpty;
    if (_hasDraftNotifier.value != hasDraft) {
      _hasDraftNotifier.value = hasDraft;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    _hasDraftNotifier.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_images.length >= _maxImages) return;

    final picked = await _imagePicker.pickMultiImage(limit: _maxImages - _images.length);

    if (picked.isNotEmpty) {
      setState(() => _images.addAll(picked.map((item) => File(item.path))));
      _onTextChanged();
    }
  }

  void _insertText(String text) {
    if (!_controller.selection.isValid) {
      _controller.text += text;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    } else {
      final textSelection = _controller.selection;
      final newText = _controller.text.replaceRange(
        textSelection.start,
        textSelection.end,
        text,
      );
      final myTextLength = text.length;
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start + myTextLength,
        extentOffset: textSelection.start + myTextLength,
      );
    }
  }

  void _showEmojiPicker() {
    _showPublishDynamicEmojiPicker(context: context, onEmojiSelected: _insertText);
  }

  void _showTopicPicker() {
    _showPublishDynamicTopicPicker(
      context: context,
      onTopicSelected: (topic) => _insertText('#$topic# '),
    );
  }

  Future<bool> _onWillPop() {
    return _confirmDiscardDynamicDraft(context: context, hasDraft: _hasDraft);
  }

  Future<void> _publish() async {
    if (_controller.text.trim().isEmpty && _images.isEmpty) return;
    final t = Translations.of(context);
    final notifier = ref.read(_publishDynamicControllerProvider.notifier);

    final error = await notifier.publish(content: _controller.text, images: _images);
    if (error == null) {
      if (mounted) {
        Navigator.pop(context);
        context.showAppFeedback(t.moments.publish_success);
      }
      return;
    }
    if (mounted) {
      context.showAppFeedback(
        t.moments.publish_failed(error: error),
        level: AppFeedbackLevel.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final isPublishing = ref.watch(_publishDynamicControllerProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: _PublishDynamicScaffold(
        theme: theme,
        colorScheme: colorScheme,
        t: t,
        isPublishing: isPublishing,
        hasDraftNotifier: _hasDraftNotifier,
        onClose: () async {
          if (await _onWillPop() && context.mounted) {
            Navigator.pop(context);
          }
        },
        onPublish: _publish,
        controller: _controller,
        focusNode: _focusNode,
        images: _images,
        maxImages: _maxImages,
        onPickImage: _pickImage,
        onRemoveImageAt: (index) {
          setState(() => _images.removeAt(index));
          _onTextChanged();
        },
        onInsertMention: () => _insertText('@'),
        onPickTopic: _showTopicPicker,
        onPickEmoji: _showEmojiPicker,
      ),
    );
  }

  bool get _hasDraft => _controller.text.trim().isNotEmpty || _images.isNotEmpty;
}

void _showPublishDynamicEmojiPicker({
  required BuildContext context,
  required ValueChanged<String> onEmojiSelected,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: _PublishEmojiPicker(
          onEmojiSelected: (text) {
            onEmojiSelected(text);
            Navigator.pop(context);
          },
        ),
      );
    },
  );
}

class _PublishEmojiPicker extends ConsumerStatefulWidget {
  final ValueChanged<String> onEmojiSelected;

  const _PublishEmojiPicker({required this.onEmojiSelected});

  @override
  ConsumerState<_PublishEmojiPicker> createState() => _PublishEmojiPickerState();
}

class _PublishEmojiPickerState extends ConsumerState<_PublishEmojiPicker>
    with TickerProviderStateMixin {
  TabController? _tabController;
  late Future<List<EmoteCatalogPackage>> _emotePackagesFuture;

  @override
  void initState() {
    super.initState();
    _emotePackagesFuture = _loadEmotePackages();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Container(
      height: 300,
      color: Theme.of(context).colorScheme.surface,
      child: FutureBuilder<List<EmoteCatalogPackage>>(
        future: _emotePackagesFuture,
        builder: (context, snapshot) {
          final packages = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return AppErrorWidget(
              error: snapshot.error!,
              stackTrace: snapshot.stackTrace,
              onRetry: _retryLoadEmotes,
              variant: AppErrorWidgetVariant.compact,
            );
          }

          if (packages == null) {
            return Center(child: Text(t.common.no_content));
          }

          if (packages.isEmpty) {
            return Center(child: Text(t.common.no_content));
          }

          if (_tabController == null || _tabController!.length != packages.length) {
            _tabController?.dispose();
            _tabController = TabController(length: packages.length, vsync: this);
          }

          return Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: packages.map(_buildEmojiGrid).toList(),
                ),
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: packages
                    .map(
                      (package) => Tab(
                        child: ExtendedImage.network(
                          package.url,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                          cacheWidth: 48,
                          cacheHeight: 48,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<List<EmoteCatalogPackage>> _loadEmotePackages() async {
    final response = await ref.read(emoteRepositoryProvider).getUserEmotePackages();
    return response.when(success: (data) => data, failure: (error) => throw error);
  }

  void _retryLoadEmotes() {
    setState(() {
      _emotePackagesFuture = _loadEmotePackages();
    });
  }

  Widget _buildEmojiGrid(EmoteCatalogPackage package) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 48,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: package.emotes.length,
      itemBuilder: (context, index) {
        final emote = package.emotes[index];
        return InkWell(
          onTap: () => widget.onEmojiSelected(emote.text),
          child: ExtendedImage.network(
            emote.url,
            fit: BoxFit.contain,
            cacheWidth: 96,
            cacheHeight: 96,
          ),
        );
      },
    );
  }
}

void _showPublishDynamicTopicPicker({
  required BuildContext context,
  required ValueChanged<String> onTopicSelected,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return _PublishTopicPicker(
        onTopicSelected: (topic) {
          onTopicSelected(topic);
          Navigator.pop(context);
        },
      );
    },
  );
}

class _PublishTopicPicker extends HookConsumerWidget {
  final ValueChanged<String> onTopicSelected;

  const _PublishTopicPicker({required this.onTopicSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final searchController = useTextEditingController();
    final searchKeyword = useState('');
    final debounceTimer = useRef<Timer?>(null);
    final searchResultAsync = ref.watch(topicSearchProvider(searchKeyword.value));
    final topics = searchResultAsync.asData?.value ?? const [];

    void onSearchChanged(String value) {
      debounceTimer.value?.cancel();
      debounceTimer.value = Timer(const Duration(milliseconds: 500), () {
        searchKeyword.value = value;
      });
    }

    useEffect(() {
      return () => debounceTimer.value?.cancel();
    }, const []);

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: CulculRadius.radiusLg),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(CulculSpacing.md),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: t.moments.topic_search_hint,
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.5,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(CulculRadius.lg),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: CulculSpacing.md,
                      ),
                      isDense: true,
                    ),
                    onChanged: onSearchChanged,
                    autofocus: true,
                  ),
                ),
                const SizedBox(width: CulculSpacing.sm),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(t.common.cancel),
                ),
              ],
            ),
          ),
          Expanded(
            child: searchResultAsync.isLoading
                ? const Center(child: CircularProgressIndicator())
                : topics.isEmpty
                ? Center(
                    child: Text(
                      searchKeyword.value.isEmpty
                          ? t.moments.topic_search_empty
                          : t.moments.topic_search_no_result,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  )
                : ListView.builder(
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      final title = FormatUtils.stripHtmlTags(topic.title);

                      return ListTile(
                        leading: topic.coverUrl != null
                            ? AppNetworkImage(
                                url: topic.coverUrl!,
                                width: 40,
                                height: 40,
                                borderRadius: BorderRadius.circular(CulculRadius.xs),
                              )
                            : Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(CulculRadius.xs),
                                ),
                                child: Icon(
                                  Icons.tag,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              ),
                        title: Text(title),
                        subtitle: topic.description != null
                            ? Text(
                                FormatUtils.stripHtmlTags(topic.description!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : null,
                        onTap: () => onTopicSelected(title),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

Future<bool> _confirmDiscardDynamicDraft({
  required BuildContext context,
  required bool hasDraft,
}) async {
  if (!hasDraft) return true;
  final t = Translations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.moments.discard_title),
      content: Text(t.moments.discard_confirm),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(t.common.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(t.moments.discard_action),
        ),
      ],
    ),
  );
  return result == true;
}

class _PublishDynamicScaffold extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;
  final Translations t;
  final bool isPublishing;
  final ValueNotifier<bool> hasDraftNotifier;
  final Future<void> Function() onClose;
  final Future<void> Function() onPublish;
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<File> images;
  final int maxImages;
  final Future<void> Function() onPickImage;
  final ValueChanged<int> onRemoveImageAt;
  final VoidCallback onInsertMention;
  final VoidCallback onPickTopic;
  final VoidCallback onPickEmoji;

  const _PublishDynamicScaffold({
    required this.theme,
    required this.colorScheme,
    required this.t,
    required this.isPublishing,
    required this.hasDraftNotifier,
    required this.onClose,
    required this.onPublish,
    required this.controller,
    required this.focusNode,
    required this.images,
    required this.maxImages,
    required this.onPickImage,
    required this.onRemoveImageAt,
    required this.onInsertMention,
    required this.onPickTopic,
    required this.onPickEmoji,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _PublishDynamicAppBar(
        theme: theme,
        colorScheme: colorScheme,
        t: t,
        isPublishing: isPublishing,
        hasDraftNotifier: hasDraftNotifier,
        onClose: onClose,
        onPublish: onPublish,
      ),
      body: Column(
        children: [
          Expanded(
            child: _PublishDynamicEditor(
              theme: theme,
              t: t,
              controller: controller,
              focusNode: focusNode,
              images: images,
              maxImages: maxImages,
              onPickImage: onPickImage,
              onRemoveImageAt: onRemoveImageAt,
            ),
          ),
          _PublishDynamicBottomToolbar(
            charCount: controller.text.length,
            onPickImage: onPickImage,
            onInsertMention: onInsertMention,
            onPickTopic: onPickTopic,
            onPickEmoji: onPickEmoji,
          ),
        ],
      ),
    );
  }
}

class _PublishDynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;
  final Translations t;
  final bool isPublishing;
  final ValueNotifier<bool> hasDraftNotifier;
  final Future<void> Function() onClose;
  final Future<void> Function() onPublish;

  const _PublishDynamicAppBar({
    required this.theme,
    required this.colorScheme,
    required this.t,
    required this.isPublishing,
    required this.hasDraftNotifier,
    required this.onClose,
    required this.onPublish,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      leading: IconButton(icon: const Icon(Icons.close), onPressed: onClose),
      title: Text(
        t.moments.publish_title,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ValueListenableBuilder<bool>(
            valueListenable: hasDraftNotifier,
            builder: (context, isPostable, _) {
              final enabled = !isPublishing && isPostable;
              return TextButton(
                onPressed: enabled ? onPublish : null,
                style: TextButton.styleFrom(
                  backgroundColor: enabled
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  foregroundColor: enabled
                      ? colorScheme.onPrimary
                      : colorScheme.onSurfaceVariant,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: isPublishing
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      )
                    : Text(
                        t.moments.publish_action,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PublishDynamicEditor extends StatelessWidget {
  const _PublishDynamicEditor({
    required this.theme,
    required this.t,
    required this.controller,
    required this.focusNode,
    required this.images,
    required this.maxImages,
    required this.onPickImage,
    required this.onRemoveImageAt,
  });

  final ThemeData theme;
  final Translations t;
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<File> images;
  final int maxImages;
  final Future<void> Function() onPickImage;
  final ValueChanged<int> onRemoveImageAt;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          maxLines: null,
          minLines: 5,
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
          decoration: InputDecoration(
            hintText: t.moments.publish_hint,
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: 12),
        _PublishDynamicImageGrid(
          images: images,
          maxImages: maxImages,
          onAddTap: onPickImage,
          onRemoveAt: onRemoveImageAt,
        ),
      ],
    );
  }
}

class _PublishDynamicBottomToolbar extends StatelessWidget {
  const _PublishDynamicBottomToolbar({
    required this.charCount,
    required this.onPickImage,
    required this.onInsertMention,
    required this.onPickTopic,
    required this.onPickEmoji,
  });

  final int charCount;
  final VoidCallback onPickImage;
  final VoidCallback onInsertMention;
  final VoidCallback onPickTopic;
  final VoidCallback onPickEmoji;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.paddingOf(context).bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _PublishToolbarAction(icon: Icons.image_outlined, onTap: onPickImage),
              const SizedBox(width: 24),
              _PublishToolbarAction(icon: Icons.alternate_email, onTap: onInsertMention),
              const SizedBox(width: 24),
              _PublishToolbarAction(icon: Icons.tag, onTap: onPickTopic),
              const SizedBox(width: 24),
              _PublishToolbarAction(
                icon: Icons.sentiment_satisfied_alt,
                onTap: onPickEmoji,
              ),
            ],
          ),
          Text('$charCount', style: TextStyle(color: colorScheme.outline, fontSize: 12)),
        ],
      ),
    );
  }
}

class _PublishToolbarAction extends StatelessWidget {
  const _PublishToolbarAction({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 26, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}

class _PublishDynamicImageGrid extends StatelessWidget {
  const _PublishDynamicImageGrid({
    required this.images,
    required this.maxImages,
    required this.onAddTap,
    required this.onRemoveAt,
  });

  final List<File> images;
  final int maxImages;
  final VoidCallback onAddTap;
  final ValueChanged<int> onRemoveAt;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final canAddMore = images.length < maxImages;
    final itemCount = images.length + (canAddMore ? 1 : 0);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (canAddMore && index == images.length) {
          return _PublishAddImageButton(onTap: onAddTap, colorScheme: colorScheme);
        }

        return _PublishImageItem(image: images[index], onRemove: () => onRemoveAt(index));
      },
    );
  }
}

class _PublishImageItem extends StatelessWidget {
  const _PublishImageItem({required this.image, required this.onRemove});

  final File image;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(image, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.scrim.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 16, color: colorScheme.onPrimary),
            ),
          ),
        ),
      ],
    );
  }
}

class _PublishAddImageButton extends StatelessWidget {
  const _PublishAddImageButton({required this.onTap, required this.colorScheme});

  final VoidCallback onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.add, size: 32, color: colorScheme.onSurfaceVariant),
      ),
    );
  }
}
