import 'package:culcul/features/dynamic/application/dynamic_detail_port.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_detail_application_providers.g.dart';

@riverpod
DynamicDetailPort dynamicDetailPort(Ref ref) {
  return ref.watch(dynamicRepositoryProvider);
}
