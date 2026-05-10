import 'package:culcul/features/live/domain/repositories/live_repository.dart';
import 'package:culcul/features/live/data/live_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_facade.g.dart';

@riverpod
LiveFacade liveFacade(Ref ref) {
  return LiveFacade(ref.watch(liveRepositoryProvider));
}

class LiveFacade {
  LiveFacade(this.repository);

  final LiveRepository repository;
}
