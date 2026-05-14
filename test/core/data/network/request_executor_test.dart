import 'package:culcul/core/data/network/endpoint_policy.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RequestExecutor', () {
    test('maps Dio failures through the shared executor', () async {
      const executor = RequestExecutor();

      final result = await executor.run<String>(() {
        throw DioException(
          requestOptions: RequestOptions(path: '/x/web-interface/search'),
          type: DioExceptionType.connectionError,
          error: 'socket closed',
        );
      });

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isA<NetworkAppError>());
    });

    test('maps cancellation to cancel app error', () async {
      const executor = RequestExecutor();

      final result = await executor.run<String>(() {
        throw DioException(
          requestOptions: RequestOptions(path: '/x/web-interface/search'),
          type: DioExceptionType.cancel,
        );
      });

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isA<CancelAppError>());
    });

    test('passes endpoint request class into Dio extras', () {
      const options = RequestExecutionOptions(requestClass: EndpointRequestClass.search);

      expect(
        options.toDioExtras(),
        containsPair(EndpointPolicy.requestClassExtra, EndpointRequestClass.search),
      );
    });

    test('stale-cache fallback only triggers when opted in', () async {
      const executor = RequestExecutor();

      final withoutFallback = await executor.run<String>(() {
        throw const AppError.network('offline');
      });
      final withFallback = await executor.run<String>(
        () {
          throw const AppError.network('offline');
        },
        options: RequestExecutionOptions(
          requestClass: EndpointRequestClass.search,
          staleCacheFallback: (_) async => 'cached result',
        ),
      );

      expect(withoutFallback.isFailure, isTrue);
      expect(withFallback.dataOrNull, 'cached result');
    });

    test('runUnit applies request error mapping', () async {
      const executor = RequestExecutor();

      final result = await executor.runUnit<void>(
        () => throw DioException(
          requestOptions: RequestOptions(path: '/x/v2/reply/add'),
          type: DioExceptionType.connectionError,
        ),
        options: RequestExecutionOptions(
          requestClass: EndpointRequestClass.mutation,
          errorMapper: (_) => const AppError.server('mapped'),
        ),
      );

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull?.message, 'mapped');
    });

    test('runVoid applies request error mapping', () async {
      const executor = RequestExecutor();

      final result = await executor.runVoid(
        () => throw const AppError.server('raw'),
        options: RequestExecutionOptions(
          requestClass: EndpointRequestClass.mutation,
          errorMapper: (_) => const AppError.server('mapped void'),
        ),
      );

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull?.message, 'mapped void');
    });
  });
}
