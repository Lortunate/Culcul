import 'dart:async';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/search/search_result.dart';
import 'package:culcul/features/search/data/search_repository.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopicPicker extends HookConsumerWidget {
  final ValueChanged<String> onTopicSelected;

  const TopicPicker({super.key, required this.onTopicSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final searchController = useTextEditingController();
    final searchKeyword = useState('');
    final searchResults = useState<List<SearchTopicModel>>([]);
    final isLoading = useState(false);
    final debounceTimer = useRef<Timer?>(null);

    Future<void> searchTopics(String keyword) async {
      if (keyword.isEmpty) {
        searchResults.value = [];
        return;
      }

      isLoading.value = true;
      try {
        final data = await ref
            .read(searchRepositoryProvider)
            .fetchSearchAll(keyword: keyword, searchType: 'topic');
        final topics = data.result
            .map((e) => e.mapOrNull(topic: (t) => t))
            .whereType<SearchTopicModel>()
            .toList();
        searchResults.value = topics;
      } catch (e) {
        debugPrint('Search topic error: $e');
      } finally {
        isLoading.value = false;
      }
    }

    void onSearchChanged(String value) {
      searchKeyword.value = value;
      debounceTimer.value?.cancel();
      debounceTimer.value = Timer(const Duration(milliseconds: 500), () {
        searchTopics(value);
      });
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
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
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      isDense: true,
                    ),
                    onChanged: onSearchChanged,
                    autofocus: true,
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(t.common.cancel),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : searchResults.value.isEmpty
                ? Center(
                    child: Text(
                      searchKeyword.value.isEmpty
                          ? t.moments.topic_search_empty
                          : t.moments.topic_search_no_result,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  )
                : ListView.builder(
                    itemCount: searchResults.value.length,
                    itemBuilder: (context, index) {
                      final topic = searchResults.value[index];
                      return ListTile(
                        leading: topic.cover != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: AppNetworkImage(
                                  url: topic.cover!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Icon(
                                  Icons.tag,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              ),
                        title: Text(FormatUtils.stripHtmlTags(topic.title ?? '')),
                        subtitle: topic.description != null
                            ? Text(
                                FormatUtils.stripHtmlTags(topic.description!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : null,
                        onTap: () {
                          onTopicSelected(FormatUtils.stripHtmlTags(topic.title ?? ''));
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
