import 'package:culcul/features/to_view/domain/repositories/to_view_repository.dart';
import 'package:culcul/features/to_view/data/to_view_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_view_facade.g.dart';

@riverpod
ToViewFacade toViewFacade(Ref ref) {
  return ToViewFacade(ref.watch(toViewRepositoryProvider));
}

class ToViewFacade {
  ToViewFacade(this.repository);

  final ToViewRepository repository;
}
