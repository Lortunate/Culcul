import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
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

  Future<EmoteResponse> getUserEmotes({String business = 'dynamic'}) {
    return requestApi(() => _api.getUserEmotes(business: business));
  }
}
