import 'dart:async';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/search/application/search_application_providers.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
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
                      return ListTile(
                        leading: topic.coverUrl != null
                            ? AppNetworkImage(
                                url: topic.coverUrl!,
                                width: 40,
                                height: 40,
                                borderRadius: BorderRadius.circular(4),
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
                        title: Text(FormatUtils.stripHtmlTags(topic.title)),
                        subtitle: topic.description != null
                            ? Text(
                                FormatUtils.stripHtmlTags(topic.description!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : null,
                        onTap: () {
                          onTopicSelected(FormatUtils.stripHtmlTags(topic.title));
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
