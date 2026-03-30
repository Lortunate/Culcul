import 'package:culcul/features/search/application/use_case/search_use_cases.dart';
import 'package:culcul/features/search/domain/entities/search_result_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final topicSearchViewModelProvider = FutureProvider.autoDispose
    .family<List<SearchTopicEntry>, String>((ref, keyword) async {
      final trimmed = keyword.trim();
      if (trimmed.isEmpty) return const [];

      final result = await ref
          .read(searchUseCasesProvider)
          .search(SearchQuery(keyword: trimmed, searchType: 'topic'));
      final data = result.when(
        success: (value) => value,
        failure: (error) => throw error,
      );
      return data.items.whereType<SearchTopicEntry>().toList();
    });
