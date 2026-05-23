import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/dynamic/data/dtos/emote_response.dart';
import 'package:culcul/features/dynamic/data/emote_api.dart';
import 'package:culcul/features/dynamic/data/emote_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getUserEmotePackages maps transport DTOs to catalog models', () async {
    final api = _FakeEmoteApi(
      const EmoteResponse(
        packages: [
          EmotePackage(
            id: 1,
            text: 'Favorites',
            url: 'https://example.test/package.png',
            emote: [Emote(id: 2, text: 'Wave', url: 'https://example.test/wave.png')],
          ),
        ],
      ),
    );
    final repository = EmoteRepositoryImpl(api);

    final result = await repository.getUserEmotePackages();

    expect(api.requestedBusiness, 'dynamic');
    final packages = result.dataOrNull;
    expect(packages, isNotNull);
    expect(packages, hasLength(1));
    final package = packages!.single;
    expect(package.id, 1);
    expect(package.text, 'Favorites');
    expect(package.url, 'https://example.test/package.png');
    expect(package.emotes, hasLength(1));
    final emote = package.emotes.single;
    expect(emote.id, 2);
    expect(emote.text, 'Wave');
    expect(emote.url, 'https://example.test/wave.png');
  });
}

final class _FakeEmoteApi implements EmoteApi {
  _FakeEmoteApi(this.response);

  final EmoteResponse response;
  String? requestedBusiness;

  @override
  Future<ApiResponse<EmoteResponse>> getUserEmotes({String business = 'dynamic'}) async {
    requestedBusiness = business;
    return ApiResponse(code: 0, message: '0', data: response);
  }
}
