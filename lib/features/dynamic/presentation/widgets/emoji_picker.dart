import 'package:culcul/features/dynamic/application/models/emote_response.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/dynamic/presentation/view_models/emote_view_model.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmojiPicker extends ConsumerStatefulWidget {
  final Function(String) onEmojiSelected;

  const EmojiPicker({super.key, required this.onEmojiSelected});

  @override
  ConsumerState<EmojiPicker> createState() => _EmojiPickerState();
}

class _EmojiPickerState extends ConsumerState<EmojiPicker> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emotesAsync = ref.watch(emotePackagesProvider);
    final t = Translations.of(context);

    return Container(
      height: 300,
      color: Theme.of(context).colorScheme.surface,
      child: emotesAsync.when(
        data: (packages) {
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => AppErrorWidget(
          error: err,
          stackTrace: stack,
          onRetry: () => ref.refresh(emotePackagesProvider),
          variant: AppErrorWidgetVariant.compact,
        ),
      ),
    );
  }

  Widget _buildEmojiGrid(EmotePackage package) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 48,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: package.emote.length,
      itemBuilder: (context, index) {
        final emote = package.emote[index];
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
