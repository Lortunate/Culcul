import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/resource_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resource_api_provider.g.dart';

@riverpod
ResourceApi basicResourceApi(Ref ref) {
  return ResourceApi(ref.watch(basicDioProvider));
}

@riverpod
ResourceApi resourceApi(Ref ref) {
  return ResourceApi(ref.watch(dioClientProvider));
}
