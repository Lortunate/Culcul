import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('provider owns and disposes the prefetcher instance', () {
    final prefetcher = AppNetworkImagePrefetcher();
    final container = ProviderContainer(
      overrides: [
        appNetworkImagePrefetcherProvider.overrideWith((ref) {
          ref.onDispose(prefetcher.dispose);
          return prefetcher;
        }),
      ],
    );

    expect(container.read(appNetworkImagePrefetcherProvider), same(prefetcher));
    expect(prefetcher.isDisposed, isFalse);

    container.dispose();

    expect(prefetcher.isDisposed, isTrue);
    expect(prefetcher.queuedTaskCount, 0);
    expect(prefetcher.inFlightTaskCount, 0);
    expect(prefetcher.rememberedKeyCount, 0);
  });
}
