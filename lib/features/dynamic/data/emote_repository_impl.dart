import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/features/dynamic/data/dtos/emote_response.dart' as dto;
import 'package:culcul/features/dynamic/data/emote_api.dart';
import 'package:culcul/features/dynamic/domain/entities/emote_response.dart'
    as domain_entity;
import 'package:culcul/features/dynamic/domain/repositories/emote_repository.dart'
    as domain;
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
  Future<domain_entity.EmoteResponse> getUserEmotes() async {
    final data = await requestApi(() => _api.getUserEmotes(business: 'dynamic'));
    return data.toDomain();
  }
}

extension EmoteResponseMapper on dto.EmoteResponse {
  domain_entity.EmoteResponse toDomain() {
    return domain_entity.EmoteResponse(
      packages: packages.map((item) => item.toDomain()).toList(),
    );
  }
}

extension EmotePackageMapper on dto.EmotePackage {
  domain_entity.EmotePackage toDomain() {
    return domain_entity.EmotePackage(
      id: id,
      text: text,
      url: url,
      emote: emote.map((item) => item.toDomain()).toList(),
    );
  }
}

extension EmoteMapper on dto.Emote {
  domain_entity.Emote toDomain() {
    return domain_entity.Emote(id: id, text: text, url: url);
  }
}
