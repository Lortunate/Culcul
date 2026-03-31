import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/search_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final topicSearchViewModelProvider = FutureProvider.autoDispose
    .family<List<SearchTopicEntry>, String>((ref, keyword) async {
      final trimmed = keyword.trim();
      if (trimmed.isEmpty) return const [];

      final data = await ref
          .read(searchRepositoryProvider)
          .search(keyword: trimmed, searchType: 'topic');
      return data.items.whereType<SearchTopicEntry>().toList();
    });
