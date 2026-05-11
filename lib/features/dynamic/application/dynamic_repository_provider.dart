import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart' as data;
import 'package:culcul/features/dynamic/domain/repositories/dynamic_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dynamicRepositoryProvider = data.dynamicRepositoryProvider;

final dynamicRepositoryEntryProvider = Provider<DynamicRepository>((ref) {
  return ref.watch(dynamicRepositoryProvider);
});
