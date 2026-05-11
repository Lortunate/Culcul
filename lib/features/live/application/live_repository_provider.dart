import 'package:culcul/features/live/data/live_repository_impl.dart' as data;
import 'package:culcul/features/live/domain/repositories/live_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final liveRepositoryProvider = data.liveRepositoryProvider;

final liveRepositoryEntryProvider = Provider<LiveRepository>((ref) {
  return ref.watch(liveRepositoryProvider);
});
