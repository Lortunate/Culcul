import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/data/emote_api.dart';
import 'package:culcul/features/dynamic/domain/entities/emote_response.dart';
import 'package:culcul/features/dynamic/domain/repositories/emote_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_repository_impl.g.dart';

@Riverpod(keepAlive: true)
domain.EmoteRepository emoteRepository(Ref ref) {
  return EmoteRepositoryImpl(EmoteApi(ref.watch(dioClientProvider)));
}

class EmoteRepositoryImpl with RequestExecutorBinding implements domain.EmoteRepository {
  final EmoteApi _api;
  final RequestExecutor _requestExecutor;

  EmoteRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  @override
  Future<Result<EmoteResponse, AppError>> getUserEmotes() async {
    final result = await requestApiResult(() => _api.getUserEmotes(business: 'dynamic'));
    return result;
  }
}
