import 'package:cilixili/data/sources/api/search_api.dart';
import 'package:cilixili/data/sources/api/video_api.dart';
import 'package:cilixili/core/network/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@riverpod
VideoApi videoApi(Ref ref) {
  return VideoApi(ref.watch(dioClientProvider));
}

@riverpod
SearchApi searchApi(Ref ref) {
  return SearchApi(ref.watch(dioClientProvider));
}
