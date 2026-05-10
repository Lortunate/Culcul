import 'package:culcul/features/dynamic/application/dynamic_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/dynamic/application/dynamic_facade.dart' show dynamicFacadeProvider;

final dynamicFacadeEntryProvider = Provider<DynamicFacade>(
  (ref) => ref.watch(dynamicFacadeProvider),
);
