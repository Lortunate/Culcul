import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/emote_api.dart';
import 'package:culcul/data/models/emote/emote_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_repository.g.dart';

@Riverpod(keepAlive: true)
EmoteRepository emoteRepository(Ref ref) {
  return EmoteRepository(ref.watch(emoteApiProvider));
}

class EmoteRepository {
  final EmoteApi _api;

  EmoteRepository(this._api);

  Future<Result<EmoteResponse, Exception>> getUserEmotes({String business = 'dynamic'}) async {
    try {
      final response = await _api.getUserEmotes(business: business);
      if (response.code == 0 && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(
          response.message,
          code: response.code,
        ));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString()));
    }
  }
}
