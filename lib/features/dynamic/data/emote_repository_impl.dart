import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/data/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/data/emote_api.dart';
import 'package:culcul/features/dynamic/data/dtos/emote_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_repository_impl.g.dart';

@Riverpod(keepAlive: true)
EmoteRepositoryImpl emoteRepository(Ref ref) {
  return EmoteRepositoryImpl(EmoteApi(ref.watch(dioClientProvider)));
}

class EmoteRepositoryImpl with RequestExecutorBinding {
  final EmoteApi _api;
  final RequestExecutor _requestExecutor;

  EmoteRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  Future<Result<EmoteResponse, AppError>> getUserEmotes() async {
    final result = await requestApiResult(() => _api.getUserEmotes(business: 'dynamic'));
    return result;
  }
}
