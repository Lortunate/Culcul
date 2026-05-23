import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/application/emote_application_providers.dart';
import 'package:culcul/features/dynamic/application/emote_port.dart';
import 'package:culcul/features/dynamic/application/models/emote_catalog.dart';
import 'package:culcul/features/dynamic/data/emote_api.dart';
import 'package:culcul/features/dynamic/data/emote_repository_impl.dart';
import 'package:culcul/features/dynamic/data/dtos/emote_response.dart';
import 'package:culcul/features/dynamic/presentation/view_models/emote_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('emote packages read through the dynamic emote application port', () async {
    const package = EmoteCatalogPackage(
      id: 1,
      text: 'Favorites',
      url: 'https://example.test/package.png',
      emotes: [
        EmoteCatalogItem(id: 2, text: 'Wave', url: 'https://example.test/wave.png'),
      ],
    );
    final port = _FakeEmotePort(packages: const [package]);
    final container = ProviderContainer(
      overrides: [
        emotePortProvider.overrideWithValue(port),
        emoteRepositoryProvider.overrideWithValue(_ThrowingEmoteRepository()),
      ],
    );
    addTearDown(container.dispose);

    final packages = await container.read(emotePackagesProvider.future);

    expect(packages, const [package]);
    expect(port.requestCount, 1);
  });
}

final class _FakeEmotePort implements EmotePort {
  _FakeEmotePort({required this.packages});

  final List<EmoteCatalogPackage> packages;
  int requestCount = 0;

  @override
  Future<Result<List<EmoteCatalogPackage>, AppError>> getUserEmotePackages() async {
    requestCount++;
    return Success(packages);
  }
}

final class _ThrowingEmoteRepository extends EmoteRepositoryImpl {
  _ThrowingEmoteRepository() : super(_UnsupportedEmoteApi());

  @override
  Future<Result<EmoteResponse, AppError>> getUserEmotes() {
    throw StateError('emoteRepositoryProvider should not be read by UI state');
  }

  @override
  Future<Result<List<EmoteCatalogPackage>, AppError>> getUserEmotePackages() {
    throw StateError('emoteRepositoryProvider should not be read by UI state');
  }
}

final class _UnsupportedEmoteApi implements EmoteApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
