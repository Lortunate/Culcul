import 'package:culcul/features/to_view/data/to_view_repository_impl.dart' as data;
import 'package:culcul/features/to_view/domain/repositories/to_view_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final toViewRepositoryProvider = data.toViewRepositoryProvider;

final toViewRepositoryEntryProvider = Provider<ToViewRepository>((ref) {
  return ref.watch(toViewRepositoryProvider);
});
