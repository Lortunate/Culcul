import 'package:culcul/features/to_view/application/to_view_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/to_view/application/to_view_facade.dart' show toViewFacadeProvider;
export 'package:culcul/features/to_view/application/to_view_repository_provider.dart'
    show toViewRepositoryProvider;

final toViewFacadeEntryProvider = Provider<ToViewFacade>(
  (ref) => ref.watch(toViewFacadeProvider),
);
