import 'package:culcul/features/home/application/home_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/home/application/home_facade.dart' show homeFacadeProvider;

final homeFacadeEntryProvider = Provider<HomeFacade>(
  (ref) => ref.watch(homeFacadeProvider),
);
