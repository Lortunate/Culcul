import 'package:culcul/core/contracts/search_query_contract.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/feature_scope.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topic_search_view_model.g.dart';

@riverpod
Future<List<SearchTopicEntry>> topicSearchViewModel(
  Ref ref,
  String keyword,
) async {
  final trimmed = keyword.trim();
  if (trimmed.isEmpty) return const [];

  final data = await ref
      .read(searchPortProvider)
      .search(
        query: SearchQuery(keyword: trimmed, type: SearchType.topic),
      );
  final page = data.dataOrNull;
  if (page == null) return const <SearchTopicEntry>[];
  return page.items.whereType<SearchTopicEntry>().toList();
}
