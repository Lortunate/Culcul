import 'package:culcul/shared/contracts/search_result_contract.dart';
import 'package:culcul/features/search/feature_scope.dart';
import 'package:culcul/features/search/domain/entities/search_query.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final topicSearchViewModelProvider = FutureProvider.autoDispose
    .family<List<SearchTopicEntry>, String>((ref, keyword) async {
      final trimmed = keyword.trim();
      if (trimmed.isEmpty) return const [];

      final data = await ref
          .read(searchRepositoryProvider)
          .search(
            query: SearchQuery(keyword: trimmed, type: SearchType.topic),
          );
      final page = data.dataOrNull;
      if (page == null) return const <SearchTopicEntry>[];
      return page.items.whereType<SearchTopicEntry>().toList();
    });
