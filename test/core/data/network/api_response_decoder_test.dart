import 'package:culcul/core/data/network/api_response_decoder.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('decodeApiResponse', () {
    test('decodes object data with a typed mapper', () {
      final decoded = decodeObjectApiResponse<String>(
        _response({
          'code': 0,
          'message': 'ok',
          'data': {'value': 'mapped'},
        }),
        (json) => json['value'] as String,
      );

      expect(decoded.code, 0);
      expect(decoded.message, 'ok');
      expect(decoded.data, 'mapped');
    });

    test('throws when response body is null by default', () {
      expect(
        () => decodeApiResponse<Object?>(_response(null), (json) => json),
        throwsStateError,
      );
    });

    test('uses explicit fallback body for null responses', () {
      final decoded = decodeApiResponse<Object?>(
        _response(null),
        (json) => json,
        nullBody: const {'code': 0, 'message': 'ok', 'data': 'fallback'},
      );

      expect(decoded.code, 0);
      expect(decoded.data, 'fallback');
    });

    test('object decoder rejects scalar data', () {
      expect(
        () => decodeObjectApiResponse<Map<String, dynamic>>(
          _response(const {'code': 0, 'message': 'ok', 'data': 'bad'}),
          (json) => json,
        ),
        throwsStateError,
      );
    });
  });
}

Response<Map<String, dynamic>> _response(Map<String, dynamic>? data) {
  return Response<Map<String, dynamic>>(
    requestOptions: RequestOptions(path: '/test'),
    data: data,
  );
}
