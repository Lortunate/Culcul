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
import 'package:culcul/features/dynamic/models/dynamic_publish_command.dart';
import 'package:culcul/features/search/application/search_application_providers.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';
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
    final csrfResult = await repository.getPublishCsrf();
    final csrfToken = csrfResult.dataOrNull;
    if (csrfToken == null || csrfToken.isEmpty) {
      return Failure(csrfResult.errorOrNull ?? const AppError.auth('Missing csrf token'));
    }

    final uploadedImagesResult = await repository.uploadImagesWithCsrf(
      files: images,
      csrf: csrfToken,
    );
    return uploadedImagesResult.when(
      success: (images) =>
          repository.publishDynamic(content: content, csrf: csrfToken, images: images),
      failure: (error) async => Failure(error),
    );
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
    final canAddMoreImages = _images.length < _maxImages;
    final selectedImageGridItemCount = _images.length + (canAddMoreImages ? 1 : 0);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _confirmDiscardDynamicDraft(
          context: context,
          hasDraft: _hasDraft,
        );
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              final shouldPop = await _confirmDiscardDynamicDraft(
                context: context,
                hasDraft: _hasDraft,
              );
              if (shouldPop && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(
            t.moments.publish_title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ValueListenableBuilder<bool>(
                valueListenable: _hasDraftNotifier,
                builder: (context, isPostable, _) {
                  final enabled = !isPublishing && isPostable;
                  return TextButton(
                    onPressed: enabled ? _publish : null,
                    style: TextButton.styleFrom(
                      backgroundColor: enabled
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      foregroundColor: enabled
                          ? colorScheme.onPrimary
                          : colorScheme.onSurfaceVariant,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                children: [
                  TextField(
                    controller: _controller,
                    focusNode: _focusNode,
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
                  if (_images.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: selectedImageGridItemCount,
                      itemBuilder: (context, index) {
                        if (canAddMoreImages && index == _images.length) {
                          return InkWell(
                            onTap: _pickImage,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest.withValues(
                                  alpha: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 32,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        }

                        return Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(_images[index], fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => _images.removeAt(index));
                                  _onTextChanged();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: colorScheme.scrim.withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
                bottom: MediaQuery.paddingOf(context).bottom + 12,
              ),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: _pickImage,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.image_outlined,
                            size: 26,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () => _insertText('@'),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.alternate_email,
                            size: 26,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (sheetContext) {
                              return _PublishTopicPicker(
                                onTopicSelected: (topic) {
                                  _insertText('#$topic# ');
                                  Navigator.pop(sheetContext);
                                },
                              );
                            },
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(Icons.tag, size: 26, color: colorScheme.onSurface),
                        ),
                      ),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (sheetContext) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(sheetContext).colorScheme.surface,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                child: _PublishEmojiPicker(
                                  onEmojiSelected: (text) {
                                    _insertText(text);
                                    Navigator.pop(sheetContext);
                                  },
                                ),
                              );
                            },
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.sentiment_satisfied_alt,
                            size: 26,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${_controller.text.length}',
                    style: TextStyle(color: colorScheme.outline, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _hasDraft => _controller.text.trim().isNotEmpty || _images.isNotEmpty;
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
    _emotePackagesFuture = ref
        .read(emoteRepositoryProvider)
        .getUserEmotePackages()
        .then(
          (response) =>
              response.when(success: (data) => data, failure: (error) => throw error),
        );
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
              onRetry: () {
                setState(() {
                  _emotePackagesFuture = ref
                      .read(emoteRepositoryProvider)
                      .getUserEmotePackages()
                      .then(
                        (response) => response.when(
                          success: (data) => data,
                          failure: (error) => throw error,
                        ),
                      );
                });
              },
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
                  children: packages
                      .map(
                        (package) => GridView.builder(
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
                        ),
                      )
                      .toList(),
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
