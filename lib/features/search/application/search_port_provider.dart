import 'package:culcul/core/contracts/search_port.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchPortProvider = Provider<SearchPort>((ref) {
  return ref.read(searchRepositoryProvider);
});
