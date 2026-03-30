import 'package:culcul/data/models/search/search_result.dart';
import 'package:culcul/features/search/data/search_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final topicSearchViewModelProvider = FutureProvider.autoDispose
    .family<List<SearchTopicModel>, String>((ref, keyword) async {
      final trimmed = keyword.trim();
      if (trimmed.isEmpty) return const [];

      final data = await ref
          .read(searchRepositoryProvider)
          .fetchSearchAll(keyword: trimmed, searchType: 'topic');
      return data.result
          .map((e) => e.mapOrNull(topic: (topic) => topic))
          .whereType<SearchTopicModel>()
          .toList();
    });
