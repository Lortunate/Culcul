import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/features/dynamic/data/emote_api.dart';
import 'package:culcul/features/dynamic/domain/repositories/emote_repository.dart'
    as domain;
import 'package:culcul/features/dynamic/models/dynamic_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_repository.g.dart';

@Riverpod(keepAlive: true)
domain.EmoteRepository emoteRepository(Ref ref) {
  return EmoteRepositoryImpl(ref.watch(emoteApiProvider));
}

class EmoteRepositoryImpl extends BaseRepository implements domain.EmoteRepository {
  final EmoteApi _api;

  EmoteRepositoryImpl(this._api);

  @override
  Future<EmoteResponse> getUserEmotes({String business = 'dynamic'}) {
    return requestApi(() => _api.getUserEmotes(business: business));
  }
}
