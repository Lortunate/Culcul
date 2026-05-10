import 'package:culcul/features/dynamic/domain/repositories/dynamic_repository.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_facade.g.dart';

@riverpod
DynamicFacade dynamicFacade(Ref ref) {
  return DynamicFacade(ref.watch(dynamicRepositoryProvider));
}

class DynamicFacade {
  DynamicFacade(this.repository);

  final DynamicRepository repository;
}
