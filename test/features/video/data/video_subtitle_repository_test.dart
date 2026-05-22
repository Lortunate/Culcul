import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:culcul/core/data/network/resource_api.dart';
import 'package:culcul/core/services/comment_service.dart';
import 'package:culcul/features/video/data/video_api.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';

void main() {
  test('fetchSubtitleContent maps transport JSON to subtitle content', () async {
    final resourceApi = _FakeResourceApi({
      'font_size': 0.4,
      'font_color': '#fff',
      'background_alpha': 0.2,
      'background_color': '#000',
      'body': [
        {'from': 1.5, 'to': 3.0, 'location': 2, 'content': 'hello'},
      ],
    });
    final repository = VideoRepositoryImpl(
      api: _UnusedVideoApi(),
      commentService: CommentService(Dio()),
      resourceApi: resourceApi,
    );

    final result = await repository.fetchSubtitleContent('//example.test/subtitle.json');

    expect(resourceApi.requestedUrl, 'https://example.test/subtitle.json');
    final content = result.dataOrNull;
    expect(content, isNotNull);
    expect(content!.fontSize, 0.4);
    expect(content.fontColor, '#fff');
    expect(content.backgroundAlpha, 0.2);
    expect(content.backgroundColor, '#000');
    expect(content.body, hasLength(1));
    expect(content.body.single.from, 1.5);
    expect(content.body.single.to, 3.0);
    expect(content.body.single.location, 2);
    expect(content.body.single.content, 'hello');
  });
}

final class _FakeResourceApi implements ResourceApi {
  _FakeResourceApi(this.response);

  final Map<String, Object?> response;
  String? requestedUrl;

  @override
  Future<dynamic> fetchJson(String url) async {
    requestedUrl = url;
    return response;
  }

  @override
  Future<List<int>> fetchBytes(String url) async => throw UnimplementedError();

  @override
  Future<dynamic> fetchNav() async => throw UnimplementedError();
}

final class _UnusedVideoApi implements VideoApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
