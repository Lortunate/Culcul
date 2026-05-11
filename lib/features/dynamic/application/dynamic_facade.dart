import 'package:culcul/features/dynamic/domain/repositories/dynamic_repository.dart';
import 'package:culcul/features/dynamic/application/dynamic_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_facade.g.dart';

@riverpod
DynamicFacade dynamicFacade(Ref ref) {
  return DynamicFacade(ref.watch(dynamicRepositoryEntryProvider));
}

class DynamicFacade {
  DynamicFacade(DynamicRepository repository) : _repository = repository;

  // ignore: unused_field
  final DynamicRepository _repository;
}
