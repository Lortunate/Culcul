import 'package:culcul/features/live/domain/repositories/live_repository.dart';
import 'package:culcul/features/live/application/live_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_facade.g.dart';

@riverpod
LiveFacade liveFacade(Ref ref) {
  return LiveFacade(ref.watch(liveRepositoryEntryProvider));
}

class LiveFacade {
  LiveFacade(LiveRepository repository) : _repository = repository;

  // ignore: unused_field
  final LiveRepository _repository;
}
