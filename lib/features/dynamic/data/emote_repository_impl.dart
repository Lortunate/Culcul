import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/features/dynamic/application/models/emote_catalog.dart';
import 'package:culcul/features/dynamic/data/emote_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_repository_impl.g.dart';

@Riverpod(keepAlive: true)
EmoteRepositoryImpl emoteRepository(Ref ref) {
  return EmoteRepositoryImpl(EmoteApi(ref.watch(dioClientProvider)));
}

class EmoteRepositoryImpl {
  final EmoteApi _api;
  final RequestExecutor _requestExecutor;

  EmoteRepositoryImpl(
    this._api, {
    RequestExecutor requestExecutor = const RequestExecutor(),
  }) : _requestExecutor = requestExecutor;

  Future<Result<List<EmoteCatalogPackage>, AppError>> getUserEmotePackages() async {
    return _requestExecutor.runApi<List<EmoteCatalogPackage>, Object>(
      _api.getUserEmotes,
      transform: (data) {
        final map = JsonUtils.asStringKeyedMap(data);
        final packages = map?['packages'];
        if (packages is! List) {
          throw const FormatException('Missing emote packages');
        }

        return [for (final package in packages) EmoteCatalogPackage.fromObject(package)];
      },
    );
  }
}
