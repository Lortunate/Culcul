import 'package:culcul/features/to_view/domain/repositories/to_view_repository.dart';
import 'package:culcul/features/to_view/application/to_view_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_view_facade.g.dart';

@riverpod
ToViewFacade toViewFacade(Ref ref) {
  return ToViewFacade(ref.watch(toViewRepositoryEntryProvider));
}

class ToViewFacade {
  ToViewFacade(ToViewRepository repository) : _repository = repository;

  // ignore: unused_field
  final ToViewRepository _repository;
}
