import 'package:culcul/data/models/emote/emote_response.dart';
import 'package:culcul/features/dynamic/providers/emote_provider.dart';
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
  Widget build(BuildContext context) {
    final emotesAsync = ref.watch(emotePackagesProvider);

    return Container(
      height: 300,
      color: Theme.of(context).colorScheme.surface,
      child: emotesAsync.when(
        data: (packages) {
          if (packages.isEmpty) {
            return const Center(child: Text('暂无表情包'));
          }

          if (_tabController == null || _tabController!.length != packages.length) {
            _tabController = TabController(length: packages.length, vsync: this);
          }

          return Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: packages.map((package) => _buildEmojiGrid(package)).toList(),
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
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('加载失败: $err')),
      ),
    );
  }

  Widget _buildEmojiGrid(EmotePackage package) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 48,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: package.emote.length,
      itemBuilder: (context, index) {
        final emote = package.emote[index];
        return InkWell(
          onTap: () => widget.onEmojiSelected(emote.text),
          child: ExtendedImage.network(emote.url, fit: BoxFit.contain),
        );
      },
    );
  }
}
