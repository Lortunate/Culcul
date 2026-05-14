import 'package:culcul/core/data/network/endpoint_policy.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:dio/dio.dart';

typedef AppErrorMapper = AppError Function(Object error);
typedef StaleCacheFallback = Future<Object?> Function(AppError error);

class RequestExecutionOptions {
  final EndpointRequestClass? requestClass;
  final CancelToken? cancelToken;
  final Duration? cacheTtlOverride;
  final AppErrorMapper? errorMapper;
  final StaleCacheFallback? staleCacheFallback;

  const RequestExecutionOptions({
    this.requestClass,
    this.cancelToken,
    this.cacheTtlOverride,
    this.errorMapper,
    this.staleCacheFallback,
  });

  Map<String, dynamic>? toDioExtras() {
    final extras = <String, dynamic>{};
    final requestClass = this.requestClass;
    if (requestClass != null) {
      extras[EndpointPolicy.requestClassExtra] = requestClass;
    }
    final cacheTtlOverride = this.cacheTtlOverride;
    if (cacheTtlOverride != null) {
      extras[EndpointPolicy.cacheTtlOverrideExtra] = cacheTtlOverride;
    }
    return extras.isEmpty ? null : extras;
  }
}

class RequestExecutor {
  const RequestExecutor();

  Future<Result<T, AppError>> run<T>(
    Future<T> Function() action, {
    RequestExecutionOptions? options,
  }) async {
    try {
      return Success(await action());
    } catch (error) {
      final appError = options?.errorMapper?.call(error) ?? AppError.fromObject(error);
      final staleFallback = options?.staleCacheFallback;
      if (staleFallback != null) {
        final staleValue = await staleFallback(appError);
        if (staleValue is T) {
          return Success(staleValue);
        }
      }
      return Failure(appError);
    }
  }

  Future<Result<T, AppError>> runApi<T, D>(
    Future<ApiResponse<D>> Function() action, {
    required T Function(D data) transform,
    RequestExecutionOptions? options,
  }) async {
    final result = await run(action, options: options);
    return result.when(
      success: (response) {
        if (!response.isSuccess) {
          return Failure(AppError.server(response.message, code: response.code));
        }
        final data = response.data;
        if (data == null) {
          return Failure(AppError.data('Response data is null', code: response.code));
        }
        try {
          return Success(transform(data));
        } catch (error) {
          return Failure(AppError.data('Failed to map response data', cause: error));
        }
      },
      failure: Failure.new,
    );
  }

  Future<Result<T, AppError>> runResponse<R, T>(
    Future<R> Function() action, {
    required bool Function(R response) isSuccess,
    required T? Function(R response) data,
    required String Function(R response) message,
    int? Function(R response)? code,
    RequestExecutionOptions? options,
  }) async {
    final result = await run(action, options: options);
    return result.when(
      success: (response) {
        if (!isSuccess(response)) {
          return Failure(AppError.server(message(response), code: code?.call(response)));
        }
        final value = data(response);
        if (value == null) {
          return Failure(
            AppError.data('Response data is null', code: code?.call(response)),
          );
        }
        return Success(value);
      },
      failure: Failure.new,
    );
  }

  Future<Result<void, AppError>> runUnit<D>(
    Future<ApiResponse<D>> Function() action, {
    RequestExecutionOptions? options,
  }) async {
    final result = await run(action, options: options);
    return result.when(
      success: (response) {
        if (!response.isSuccess) {
          return Failure(AppError.server(response.message, code: response.code));
        }
        return const Success(null);
      },
      failure: Failure.new,
    );
  }

  Future<Result<void, AppError>> runVoid(
    Future<void> Function() action, {
    RequestExecutionOptions? options,
  }) async {
    final result = await run(action, options: options);
    return result.when(success: (_) => const Success(null), failure: Failure.new);
  }

  Future<Result<T, AppError>> runApiDirect<T>(
    Future<ApiResponse<T>> Function() action, {
    RequestExecutionOptions? options,
  }) {
    return runApi<T, T>(action, transform: (data) => data, options: options);
  }
}
