import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/features/dynamic/data/emote_api.dart';
import 'package:culcul/features/dynamic/domain/repositories/emote_repository.dart'
    as domain;
import 'package:culcul/features/dynamic/domain/entities/dynamic_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_repository_impl.g.dart';

@Riverpod(keepAlive: true)
domain.EmoteRepository emoteRepository(Ref ref) {
  return EmoteRepositoryImpl(EmoteApi(ref.watch(dioClientProvider)));
}

class EmoteRepositoryImpl extends BaseRepository implements domain.EmoteRepository {
  final EmoteApi _api;

  EmoteRepositoryImpl(this._api);

  @override
  Future<EmoteResponse> getUserEmotes() {
    return requestApi(() => _api.getUserEmotes(business: 'dynamic'));
  }
}

