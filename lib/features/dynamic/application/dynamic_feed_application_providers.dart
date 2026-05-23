import 'package:culcul/features/dynamic/application/dynamic_feed_port.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_feed_application_providers.g.dart';

@riverpod
DynamicFeedPort dynamicFeedPort(Ref ref) {
  return ref.watch(dynamicRepositoryProvider);
}
