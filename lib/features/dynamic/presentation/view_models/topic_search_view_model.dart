import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/search.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final topicSearchViewModelProvider = FutureProvider.autoDispose
    .family<List<SearchTopicEntry>, String>((ref, keyword) async {
      final trimmed = keyword.trim();
      if (trimmed.isEmpty) return const [];

      final data = await ref
          .read(searchRepositoryProvider)
          .search(keyword: trimmed, searchType: 'topic');
      final page = data.dataOrNull;
      if (page == null) return const <SearchTopicEntry>[];
      return page.items.whereType<SearchTopicEntry>().toList();
    });
