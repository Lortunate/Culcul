import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/application/emote_port.dart';
import 'package:culcul/features/dynamic/application/models/emote_catalog.dart';
import 'package:culcul/features/dynamic/data/emote_api.dart';
import 'package:culcul/features/dynamic/data/dtos/emote_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_repository_impl.g.dart';

@Riverpod(keepAlive: true)
EmoteRepositoryImpl emoteRepository(Ref ref) {
  return EmoteRepositoryImpl(EmoteApi(ref.watch(dioClientProvider)));
}

class EmoteRepositoryImpl implements EmotePort {
  final EmoteApi _api;
  final RequestExecutor _requestExecutor;

  EmoteRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  Future<Result<EmoteResponse, AppError>> getUserEmotes() {
    return _requestExecutor.runApiDirect(_api.getUserEmotes);
  }

  @override
  Future<Result<List<EmoteCatalogPackage>, AppError>> getUserEmotePackages() async {
    final response = await getUserEmotes();
    return response.map(
      (data) => [
        for (final package in data.packages)
          EmoteCatalogPackage(
            id: package.id,
            text: package.text,
            url: package.url,
            emotes: [
              for (final emote in package.emote)
                EmoteCatalogItem(id: emote.id, text: emote.text, url: emote.url),
            ],
          ),
      ],
    );
  }
}
