import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/api/emote_api.dart';
import 'package:culcul/data/models/emote/emote_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_repository.g.dart';

@Riverpod(keepAlive: true)
EmoteRepository emoteRepository(Ref ref) {
  return EmoteRepository(ref.watch(emoteApiProvider));
}

class EmoteRepository extends BaseRepository {
  final EmoteApi _api;

  EmoteRepository(this._api);

  Future<Result<EmoteResponse, AppException>> getUserEmotes({
    String business = 'dynamic',
  }) {
    return safeApiCall(() => _api.getUserEmotes(business: business));
  }
}

